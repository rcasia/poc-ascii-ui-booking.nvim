--- Offer list component
--- @class holiday-booking.components.OfferList
local ui = require("ascii-ui")
local Paragraph = ui.components.Paragraph
local Offer = require("holiday-booking.components.offer")
local StatusMessage = require("holiday-booking.components.status_message")
local Header = require("holiday-booking.components.header")

--- Offer list component function
--- @param props { offers: table[], isSearching: boolean, onSelect: fun(offer: table) }
--- @return table
local function OfferListComponent(props)
	props = props or {}
	local offers = props.offers or {}
	local isSearching = props.isSearching or false
	local onSelect = props.onSelect or function() end

	local offersList = {}
	if isSearching then
		table.insert(
			offersList,
			StatusMessage({ content = "🔍 Searching offers..." })
		)
		return offersList
	end

	if #offers > 0 then
		table.insert(
			offersList,
			Header({
				content = string.format("✨ %d Offers Found ✨", #offers),
			})
		)
		table.insert(offersList, Paragraph({ content = "" }))

		for _, offer in ipairs(offers) do
			table.insert(
				offersList,
				Offer({
					offer = offer,
					onSelect = onSelect,
				})
			)
		end
	end

	return offersList
end

return ui.createComponent("OfferList", OfferListComponent, {
	offers = "table",
	isSearching = "boolean",
	onSelect = "function",
})
