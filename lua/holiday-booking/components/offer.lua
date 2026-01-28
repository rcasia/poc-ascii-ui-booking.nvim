--- Single offer component
--- @class holiday-booking.components.Offer
local ui = require("ascii-ui")
local Paragraph = ui.components.Paragraph
local Button = ui.components.Button
local Segment = require("ascii-ui.buffer.segment")

--- Helper to get price color based on price range
--- @param price number
--- @return string color Hex color code
local function getPriceColor(price)
	if price >= 1100 then
		return "#FF6B6B" -- Red for expensive
	elseif price >= 950 then
		return "#FFA07A" -- Orange for medium-high
	elseif price >= 850 then
		return "#FFD700" -- Gold for medium
	else
		return "#90EE90" -- Light green for affordable
	end
end

--- Offer component function
--- @param props { offer: table, onSelect: fun(offer: table) }
--- @return table
local function OfferComponent(props)
	props = props or {}
	local offer = props.offer
	local onSelect = props.onSelect or function() end

	if not offer then
		return {}
	end

	return {
		-- Offer card header
		Segment:new({
			content = "📍 " .. offer.destination,
			color = { fg = "#87CEEB" },
		}):wrap(),

		-- Dates
		Segment:new({
			content = string.format("📅 %s → %s", offer.start_date, offer.end_date),
			color = { fg = "#DDA0DD" },
		}):wrap(),

		-- Price with color
		Segment:new({
			content = string.format("💰 €%d", offer.price),
			color = { fg = getPriceColor(offer.price) },
		}):wrap(),

		-- Description
		Segment:new({
			content = "  " .. offer.description,
			color = { fg = "#E0E0E0" },
		}):wrap(),

		-- Reserve button
		Button({
			label = "[ ✨ Book ]",
			on_press = function()
				onSelect(offer)
			end,
		}),
		Paragraph({ content = "" }),
	}
end

return ui.createComponent("Offer", OfferComponent, {
	offer = "table",
	onSelect = "function",
})
