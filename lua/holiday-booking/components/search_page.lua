--- Search page component
--- @class holiday-booking.components.SearchPage

local ui = require("ascii-ui")
local Paragraph = ui.components.Paragraph
local Button = ui.components.Button
local Header = require("holiday-booking.components.header")
local Label = require("holiday-booking.components.label")
local InputField = require("holiday-booking.components.input_field")
local OfferList = require("holiday-booking.components.offer_list")
local OfferSort = require("holiday-booking.components.offer_sort")
local useOffersSearch = require("holiday-booking.hooks.use_offers_search")

--- Search page component function
--- @param props { onNavigate: fun(page: string), onBookingCreated: fun() }
--- @return table
local function SearchPageComponent(props)
	props = props or {}
	local onNavigate = props.onNavigate or function() end
	local onBookingCreated = props.onBookingCreated or function() end

	local startDate, setStartDate = ui.hooks.useState("2025-06-01")
	local endDate, setEndDate = ui.hooks.useState("2025-06-15")
	local description, setDescription = ui.hooks.useState("")
	local searchResults, isSearching, searchOffers, clearSearchResults = useOffersSearch()
	local sortOrder, setSortOrder = ui.hooks.useState("Price: Low to High")
	local booking = require("holiday-booking.booking")

	local function handleSelectOffer(offer)
		booking.create(offer.start_date, offer.end_date, offer.destination .. " - " .. offer.description)
		clearSearchResults()
		onBookingCreated()
		vim.notify(string.format("Booking created for %s (€%d)", offer.destination, offer.price), vim.log.levels.INFO)
	end

	-- Sort offers based on current sort order
	local sortedOffers = #searchResults > 0 and OfferSort.sortOffers(searchResults, sortOrder) or searchResults

	-- Helper function to create an input field
	local function createInputField(value, placeholder)
		return InputField({
			value = value,
			placeholder = placeholder,
			onInput = function()
				-- TODO: Capture edited text from buffer
				-- For now, this allows editing but doesn't update state
			end,
		})
	end

	return {
		-- Header
		Header({ content = "  🔍 Search Offers  🔍" }),
		Paragraph({ content = "" }),

		-- Navigation button
		Button({
			label = "[ 🏠 Home ]",
			on_press = function()
				onNavigate("welcome")
			end,
		}),
		Paragraph({ content = "" }),

		-- Form fields
		Label({ content = "📅 Start date (YYYY-MM-DD):" }),
		createInputField(startDate, "2025-06-01"),
		Paragraph({ content = "" }),

		Label({ content = "📅 End date (YYYY-MM-DD):" }),
		createInputField(endDate, "2025-06-15"),
		Paragraph({ content = "" }),

		Label({ content = "🔍 Description/Destination (optional):" }),
		createInputField(description, "Search destination..."),
		Paragraph({ content = "" }),

		-- Search button
		Button({
			label = "[ 🔍 Search Offers ]",
			on_press = function()
				searchOffers(startDate, endDate, description)
			end,
		}),
		Paragraph({ content = "" }),

		-- Sort component (only show when there are results)
		unpack(#searchResults > 0 and {
			OfferSort({
				sortOrder = sortOrder,
				onSortChange = setSortOrder,
			}),
			Paragraph({ content = "" }),
		} or {}),

		-- Offers list
		OfferList({
			offers = sortedOffers,
			isSearching = isSearching,
			onSelect = handleSelectOffer,
		}),
		Paragraph({ content = "" }),
	}
end

return ui.createComponent("SearchPage", SearchPageComponent, {
	onNavigate = "function",
	onBookingCreated = "function",
})
