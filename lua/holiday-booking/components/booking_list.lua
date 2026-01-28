--- Booking list component
--- @class holiday-booking.components.BookingList
local ui = require("ascii-ui")
local Paragraph = ui.components.Paragraph
local Button = ui.components.Button
local Separator = require("holiday-booking.components.separator")
local Header = require("holiday-booking.components.header")
local Label = require("holiday-booking.components.label")
local Text = require("holiday-booking.components.text")
local StatusMessage = require("holiday-booking.components.status_message")

--- Booking list component function
--- @param props { bookings: table[], onDelete: fun(id: number) }
--- @return table
local function BookingListComponent(props)
	props = props or {}
	local bookings = props.bookings or {}
	local onDelete = props.onDelete or function() end

	local bookingList = {}
	if #bookings > 0 then
		table.insert(
			bookingList,
			Header({ content = "  📋 MY BOOKINGS" })
		)
		table.insert(bookingList, Paragraph({ content = "" }))
		for _, b in ipairs(bookings) do
			-- Booking ID
			table.insert(
				bookingList,
				Label({ content = string.format("🆔 ID: %d", b.id) })
			)

			-- Dates
			local datesText = string.format("📅 %s → %s", b.start_date, b.end_date)
			table.insert(
				bookingList,
				Text({
					content = datesText,
					color = { fg = "#DDA0DD" },
				})
			)

			-- Description
			local descText = b.description ~= "" and b.description or "(no description)"
			table.insert(
				bookingList,
				Text({ content = "📝 " .. descText })
			)

			-- Delete button
			table.insert(
				bookingList,
				Button({
					label = "[ 🗑️  Delete ]",
					on_press = function()
						onDelete(b.id)
					end,
				})
			)
			table.insert(bookingList, Paragraph({ content = "" }))
		end
	else
		table.insert(
			bookingList,
			StatusMessage({
				content = "📭 No bookings yet",
				color = { fg = "#8b949e" },
			})
		)
	end

	return bookingList
end

return ui.createComponent("BookingList", BookingListComponent, {
	bookings = "table",
	onDelete = "function",
})
