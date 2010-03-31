module GuitarsHelper
  def guitars_tab_path(guitar)
    person_path(guitar.person, :anchor => "tGuitars")
  end

  def guitars_tab_url(guitar)
    person_url(guitar.person, :anchor => "tGuitars")
  end  
end
