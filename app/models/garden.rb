class Garden < ApplicationRecord
  has_many :plots

  def below_one_hundred_harvest
    plots.joins(plants: :plot_plants)
      .where('plants.days_to_harvest <= ?', 100)
      .select('plants.*')
      .distinct
      .order(:name)
  end
end
