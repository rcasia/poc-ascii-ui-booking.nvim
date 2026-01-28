--- UI module for holiday booking interface
--- @class holiday-booking.UI
local UI = {}

local ui = require("ascii-ui")
local Paragraph = ui.components.Paragraph
local Button = ui.components.Button
local useState = ui.hooks.useState
local Segment = require("ascii-ui.buffer.segment")
local interaction_type = require("ascii-ui.interaction_type")

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

	-- Helper function to create an input field using Segment
	local function createInputField(value, placeholder)
		local displayValue = value ~= "" and value or placeholder or ""
		return Segment:new({
			content = displayValue,
			is_focusable = true,
			color = { fg = "#FFD700", bg = "#1a1a1a" },
			interactions = {
				[interaction_type.ON_INPUT] = function()
					-- TODO: Capture edited text from buffer
					-- For now, this allows editing but doesn't update state
				end,
			},
		}):wrap()
	end

	return {
		-- Header
		Segment:new({
			content = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
			color = { fg = "#4ECDC4" },
		}):wrap(),
		Segment:new({
			content = "  ✈️  HOLIDAY BOOKING  ✈️",
			color = { fg = "#FFD700" },
		}):wrap(),
		Segment:new({
			content = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
			color = { fg = "#4ECDC4" },
		}):wrap(),
		Paragraph({ content = "" }),

		-- Form fields
		Segment:new({
			content = "📅 Start date (YYYY-MM-DD):",
			color = { fg = "#87CEEB" },
		}):wrap(),
		createInputField(startDate, "2025-06-01"),
		Paragraph({ content = "" }),

		Segment:new({
			content = "📅 End date (YYYY-MM-DD):",
			color = { fg = "#87CEEB" },
		}):wrap(),
		createInputField(endDate, "2025-06-15"),
		Paragraph({ content = "" }),

		Segment:new({
			content = "🔍 Description/Destination (optional):",
			color = { fg = "#87CEEB" },
		}):wrap(),
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
