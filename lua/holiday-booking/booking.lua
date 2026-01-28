--- Booking management module
--- @class holiday-booking.Booking
local Booking = {}

--- Store for bookings
local bookings = {}

--- Create a new booking
--- @param start_date string
--- @param end_date string
--- @param description string|nil
--- @return table
function Booking.create(start_date, end_date, description)
	local booking = {
		id = #bookings + 1,
		start_date = start_date,
		end_date = end_date,
		description = description or "",
		created_at = os.time(),
	}
	table.insert(bookings, booking)
	return booking
end

--- Get all bookings
--- @return table
function Booking.list()
	return bookings
end

--- Delete a booking by id
--- @param id number
function Booking.delete(id)
	for i, booking in ipairs(bookings) do
		if booking.id == id then
			table.remove(bookings, i)
			return true
		end
	end
	return false
end

return Booking
