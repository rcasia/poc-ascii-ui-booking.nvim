--- Welcome page component
--- @class holiday-booking.components.WelcomePage

local ui = require("ascii-ui")
local Paragraph = ui.components.Paragraph
local Button = ui.components.Button
local Header = require("holiday-booking.components.header")
local Text = require("holiday-booking.components.text")

--- Welcome page component function
--- @param props { onNavigate: fun(page: string) }
--- @return table
local function WelcomePageComponent(props)
	props = props or {}
	local onNavigate = props.onNavigate or function() end

	local function handleSearchClick()
		if onNavigate then
			onNavigate("search")
		end
	end

	local function handleBookingsClick()
		if onNavigate then
			onNavigate("bookings")
		end
	end

	return {
		Header({ content = "  ✈️  HOLIDAY BOOKING  ✈️" }),
		Paragraph({ content = "" }),
		Paragraph({ content = "" }),
		Text({ content = "  Welcome to Holiday Booking!" }),
		Paragraph({ content = "" }),
		Text({ content = "  Find the best holiday offers" }),
		Text({ content = "  and manage your bookings easily." }),
		Paragraph({ content = "" }),
		Paragraph({ content = "" }),
		Button({
			label = "[ 🔍 Search Offers ]",
			on_press = handleSearchClick,
		}),
		Paragraph({ content = "" }),
		Button({
			label = "[ 📋 My Bookings ]",
			on_press = handleBookingsClick,
		}),
		Paragraph({ content = "" }),
	}
end

return ui.createComponent("WelcomePage", WelcomePageComponent, {
	onNavigate = "function",
})
