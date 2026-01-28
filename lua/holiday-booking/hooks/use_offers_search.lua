--- Hook for searching offers
--- @class holiday-booking.hooks.useOffersSearch
local useOffersSearch = {}

local useState = require("ascii-ui.hooks.use_state")

--- Mock offers database in memory
local mock_offers = {
	{
		id = 1,
		destination = "Paris, France",
		start_date = "2025-06-01",
		end_date = "2025-06-15",
		price = 1200,
		description = "Complete package with 4-star hotel",
		available = true,
	},
	{
		id = 2,
		destination = "Barcelona, Spain",
		start_date = "2025-06-05",
		end_date = "2025-06-20",
		price = 850,
		description = "Hotel in the city center, breakfast included",
		available = true,
	},
	{
		id = 3,
		destination = "Rome, Italy",
		start_date = "2025-06-01",
		end_date = "2025-06-10",
		price = 950,
		description = "Historical tour with guide included",
		available = true,
	},
	{
		id = 4,
		destination = "London, United Kingdom",
		start_date = "2025-06-15",
		end_date = "2025-06-25",
		price = 1100,
		description = "Hotel near city center, transportation included",
		available = true,
	},
	{
		id = 5,
		destination = "Amsterdam, Netherlands",
		start_date = "2025-06-10",
		end_date = "2025-06-18",
		price = 780,
		description = "Accommodation in the historic center",
		available = true,
	},
}

--- Search offers based on filters
--- @param start_date string|nil
--- @param end_date string|nil
--- @param description string|nil
--- @return table[]
local function searchOffers(start_date, end_date, description)
	local results = {}

	for _, offer in ipairs(mock_offers) do
		if not offer.available then
			goto continue
		end

		-- Filter by start date: offer should start on or before the requested end date
		-- and end on or after the requested start date (overlap check)
		if start_date and end_date then
			-- Check if there's an overlap between requested dates and offer dates
			-- Requested: [start_date, end_date]
			-- Offer: [offer.start_date, offer.end_date]
			-- Overlap exists if: offer.start_date <= end_date AND offer.end_date >= start_date
			if offer.start_date > end_date or offer.end_date < start_date then
				goto continue
			end
		elseif start_date then
			-- If only start_date is provided, offer should end on or after it
			if offer.end_date < start_date then
				goto continue
			end
		elseif end_date then
			-- If only end_date is provided, offer should start on or before it
			if offer.start_date > end_date then
				goto continue
			end
		end

		-- Filter by description (simple keyword matching)
		if description and description ~= "" then
			local desc_lower = string.lower(description)
			local offer_desc_lower = string.lower(offer.description)
			local dest_lower = string.lower(offer.destination)
			if
				not string.find(offer_desc_lower, desc_lower, 1, true)
				and not string.find(dest_lower, desc_lower, 1, true)
			then
				goto continue
			end
		end

		table.insert(results, offer)
		::continue::
	end

	return results
end

--- Hook to search for offers
--- @return table[] results Array of offer results
--- @return boolean isSearching Whether a search is in progress
--- @return fun(start_date: string, end_date: string, description?: string) search Function to trigger the search
--- @return fun() clearResults Function to clear the search results
function useOffersSearch()
	local results, setResults = useState({})
	local isSearching, setIsSearching = useState(false)

	local function search(start_date, end_date, description)
		description = description or ""

		if start_date == "" or end_date == "" then
			vim.notify("Please complete the dates", vim.log.levels.WARN)
			return
		end

		setIsSearching(true)
		local searchResults = searchOffers(start_date, end_date, description)
		setResults(searchResults)
		setIsSearching(false)

		if #searchResults == 0 then
			vim.notify("No offers found with those filters", vim.log.levels.INFO)
		else
			vim.notify(string.format("Found %d offers", #searchResults), vim.log.levels.INFO)
		end
	end

	local function clearResults()
		setResults({})
	end

	return results, isSearching, search, clearResults
end

return useOffersSearch
