-- Example usage of the holiday-booking plugin
-- This file shows how to use the plugin from Neovim

-- Require the plugin
local holiday_booking = require("holiday-booking")

-- Setup the plugin (optional)
holiday_booking.setup({
	-- Future configuration options
})

-- Open the booking interface
holiday_booking.open()

-- Or use the Neovim command:
-- :HolidayBooking
