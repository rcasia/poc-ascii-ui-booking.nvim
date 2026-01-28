--- Offer sort component
--- @class holiday-booking.components.OfferSort
local ui = require("ascii-ui")
local Button = ui.components.Button
local Label = require("holiday-booking.components.label")

--- Sort options
local SORT_OPTIONS = {
	"Price: Low to High",
	"Price: High to Low",
	"Date: Earliest First",
	"Date: Latest First",
	"Destination: A-Z",
	"Destination: Z-A",
}

--- Get the next sort option
--- @param currentSort string
--- @return string
local function getNextSortOption(currentSort)
	for i, option in ipairs(SORT_OPTIONS) do
		if option == currentSort then
			local nextIndex = (i % #SORT_OPTIONS) + 1
			return SORT_OPTIONS[nextIndex]
		end
	end
	return SORT_OPTIONS[1]
end

--- Offer sort component function
--- @param props { sortOrder: string, onSortChange: fun(sortOrder: string) }
--- @return table
local function OfferSortComponent(props)
	props = props or {}
	local sortOrder = props.sortOrder or "Price: Low to High"
	local onSortChange = props.onSortChange or function() end

	local function handleSortClick()
		local nextSort = getNextSortOption(sortOrder)
		onSortChange(nextSort)
	end

	return {
		Label({ content = "🔀 Sort:" }),
		Button({
			label = "[ " .. sortOrder .. " ]",
			on_press = handleSortClick,
		}),
	}
end

local OfferSort = ui.createComponent("OfferSort", OfferSortComponent, {
	sortOrder = "string",
	onSortChange = "function",
})

--- Sort offers based on sort order
--- @param offers table[]
--- @param sortOrder string
--- @return table[]
function OfferSort.sortOffers(offers, sortOrder)
	local sorted = vim.deepcopy(offers)

	if sortOrder == "Price: Low to High" then
		table.sort(sorted, function(a, b)
			return a.price < b.price
		end)
	elseif sortOrder == "Price: High to Low" then
		table.sort(sorted, function(a, b)
			return a.price > b.price
		end)
	elseif sortOrder == "Date: Earliest First" then
		table.sort(sorted, function(a, b)
			return a.start_date < b.start_date
		end)
	elseif sortOrder == "Date: Latest First" then
		table.sort(sorted, function(a, b)
			return a.start_date > b.start_date
		end)
	elseif sortOrder == "Destination: A-Z" then
		table.sort(sorted, function(a, b)
			return a.destination < b.destination
		end)
	elseif sortOrder == "Destination: Z-A" then
		table.sort(sorted, function(a, b)
			return a.destination > b.destination
		end)
	end

	return sorted
end

return OfferSort
