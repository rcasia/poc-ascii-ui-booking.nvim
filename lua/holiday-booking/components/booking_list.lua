--- Booking list component
--- @class holiday-booking.components.BookingList
local ui = require("ascii-ui")
local Paragraph = ui.components.Paragraph
local Button = ui.components.Button
local Segment = require("ascii-ui.buffer.segment")

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
			Segment:new({
				content = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
				color = { fg = "#4ECDC4" },
			}):wrap()
		)
		table.insert(
			bookingList,
			Segment:new({
				content = "  📋 MY BOOKINGS",
				color = { fg = "#FFD700" },
			}):wrap()
		)
		table.insert(
			bookingList,
			Segment:new({
				content = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
				color = { fg = "#4ECDC4" },
			}):wrap()
		)
		table.insert(bookingList, Paragraph({ content = "" }))
		for _, b in ipairs(bookings) do
			-- Booking ID
			table.insert(
				bookingList,
				Segment:new({
					content = string.format("🆔 ID: %d", b.id),
					color = { fg = "#87CEEB" },
				}):wrap()
			)

			-- Dates
			local datesText = string.format("📅 %s → %s", b.start_date, b.end_date)
			table.insert(
				bookingList,
				Segment:new({
					content = datesText,
					color = { fg = "#DDA0DD" },
				}):wrap()
			)

			-- Description
			local descText = b.description ~= "" and b.description or "(no description)"
			table.insert(
				bookingList,
				Segment:new({
					content = "📝 " .. descText,
					color = { fg = "#E0E0E0" },
				}):wrap()
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
			Segment:new({
				content = "📭 No bookings yet",
				color = { fg = "#8b949e" },
			}):wrap()
		)
	end

	return bookingList
end

return ui.createComponent("BookingList", BookingListComponent, {
	bookings = "table",
	onDelete = "function",
})
