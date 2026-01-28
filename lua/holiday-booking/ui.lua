--- UI module for holiday booking interface
--- @class holiday-booking.UI
local UI = {}

local ui = require("ascii-ui")
local Paragraph = ui.components.Paragraph
local Button = ui.components.Button
local useState = ui.hooks.useState
local Separator = require("holiday-booking.components.separator")
local Header = require("holiday-booking.components.header")
local Label = require("holiday-booking.components.label")
local InputField = require("holiday-booking.components.input_field")

local booking = require("holiday-booking.booking")
local BookingList = require("holiday-booking.components.booking_list")
local OfferList = require("holiday-booking.components.offer_list")
local OfferSort = require("holiday-booking.components.offer_sort")
local useOffersSearch = require("holiday-booking.hooks.use_offers_search")

--- Main holiday booking app component
--- @return table
local function HolidayBookingApp()
	local startDate, setStartDate = useState("2025-06-01")
	local endDate, setEndDate = useState("2025-06-15")
	local description, setDescription = useState("")
	local bookings, setBookings = useState(booking.list())
	local searchResults, isSearching, searchOffers, clearSearchResults = useOffersSearch()
	local sortOrder, setSortOrder = useState("Price: Low to High")

	local function handleSelectOffer(offer)
		booking.create(offer.start_date, offer.end_date, offer.destination .. " - " .. offer.description)
		setBookings(booking.list())
		clearSearchResults()
		vim.notify(
			string.format("Booking created for %s (€%d)", offer.destination, offer.price),
			vim.log.levels.INFO
		)
	end

	local function handleDeleteBooking(id)
		booking.delete(id)
		setBookings(booking.list())
		vim.notify("Booking deleted", vim.log.levels.INFO)
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
		Separator(),
		Header({ content = "  ✈️  HOLIDAY BOOKING  ✈️" }),
		Separator(),
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

		-- Booking list
		BookingList({
			bookings = bookings,
			onDelete = handleDeleteBooking,
		}),
	}
end

--- Open the holiday booking interface
function UI.open()
	local App = ui.createComponent("HolidayBookingApp", HolidayBookingApp)
	ui.mount(App)
end

return UI
