--- Offers management module
--- @class holiday-booking.Offers
local Offers = {}

--- Mock offers database
local mock_offers = {
	{
		id = 1,
		destination = "París, Francia",
		start_date = "2025-06-01",
		end_date = "2025-06-15",
		price = 1200,
		description = "Paquete completo con hotel 4 estrellas",
		available = true,
	},
	{
		id = 2,
		destination = "Barcelona, España",
		start_date = "2025-06-05",
		end_date = "2025-06-20",
		price = 850,
		description = "Hotel en el centro, desayuno incluido",
		available = true,
	},
	{
		id = 3,
		destination = "Roma, Italia",
		start_date = "2025-06-01",
		end_date = "2025-06-10",
		price = 950,
		description = "Tour histórico con guía incluido",
		available = true,
	},
	{
		id = 4,
		destination = "Londres, Reino Unido",
		start_date = "2025-06-15",
		end_date = "2025-06-25",
		price = 1100,
		description = "Hotel cerca del centro, transporte incluido",
		available = true,
	},
	{
		id = 5,
		destination = "Amsterdam, Países Bajos",
		start_date = "2025-06-10",
		end_date = "2025-06-18",
		price = 780,
		description = "Alojamiento en el centro histórico",
		available = true,
	},
}

--- Search offers based on filters
--- @param start_date string|nil
--- @param end_date string|nil
--- @param description string|nil
--- @return table[]
function Offers.search(start_date, end_date, description)
	local results = {}

	for _, offer in ipairs(mock_offers) do
		if not offer.available then
			goto continue
		end

		-- Filter by start date (offer start should be <= requested start)
		if start_date and offer.start_date > start_date then
			goto continue
		end

		-- Filter by end date (offer end should be >= requested end)
		if end_date and offer.end_date < end_date then
			goto continue
		end

		-- Filter by description (simple keyword matching)
		if description and description ~= "" then
			local desc_lower = string.lower(description)
			local offer_desc_lower = string.lower(offer.description)
			local dest_lower = string.lower(offer.destination)
			if
				not string.find(offer_desc_lower, desc_lower, 1, true)
				and not string.find(dest_lower, desc_lower, 1, true)
			then
				goto continue
			end
		end

		table.insert(results, offer)
		::continue::
	end

	return results
end

--- Get offer by id
--- @param id number
--- @return table|nil
function Offers.get_by_id(id)
	for _, offer in ipairs(mock_offers) do
		if offer.id == id then
			return offer
		end
	end
	return nil
end

return Offers
