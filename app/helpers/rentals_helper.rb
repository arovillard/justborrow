module RentalsHelper
  def rental_description(rental)
    distance_of_time_in_words(rental.end_date, rental.start_date)
  end

  def rental_info(rental)
    ((rental.end_date.to_date - rental.start_date.to_date).to_i) * rental.product.price * 100
  end
end
