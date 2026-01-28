--- Bookings page component
--- @class holiday-booking.components.BookingsPage
local ui = require("ascii-ui")
local Paragraph = ui.components.Paragraph
local Button = ui.components.Button
local Header = require("holiday-booking.components.header")
local BookingList = require("holiday-booking.components.booking_list")
local booking = require("holiday-booking.booking")

--- Bookings page component function
--- @param props { onNavigate: fun(page: string) }
--- @return table
local function BookingsPageComponent(props)
	props = props or {}
	local onNavigate = props.onNavigate or function() end

	local bookings, setBookings = ui.hooks.useState(booking.list())

	local function handleDeleteBooking(id)
		booking.delete(id)
		setBookings(booking.list())
		vim.notify("Booking deleted", vim.log.levels.INFO)
	end

	return {
		-- Header
		Header({ content = "  📋 My Bookings  📋" }),
		Paragraph({ content = "" }),

		-- Navigation buttons
		Button({
			label = "[ 🏠 Home ]",
			on_press = function()
				onNavigate("welcome")
			end,
		}),
		Paragraph({ content = "  " }),
		Button({
			label = "[ 🔍 Search Offers ]",
			on_press = function()
				onNavigate("search")
			end,
		}),
		Paragraph({ content = "" }),

		-- Booking list
		BookingList({
			bookings = bookings,
			onDelete = handleDeleteBooking,
		}),
		Paragraph({ content = "" }),
	}
end

return ui.createComponent("BookingsPage", BookingsPageComponent, {
	onNavigate = "function",
})
