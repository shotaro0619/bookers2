class SearchController < ApplicationController

  def search
    @value = params[:value]
    @model = params[:model]
    @how = params[:how]
    @datas = search_for('partical', @model, @value)
  end
  
  def Book.search(search_word)
    Book.where(['category LIKE ?', "#{search_word}"])
  end

   private


  def perfect_match(model, value)
    if model == 'user'
      User.where(name: value)
    elsif model == 'book'
      Book.where(category: value)
    end
  end

  def forward(model, value)
    if model == 'user'
      User.where("name LIKE ?", "#{value}%")
    elsif model == 'book'
      Book.where("category LIKE ?", "#{value}%")
    end
  end

  def backward(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}")
    elsif model == 'book'
      Book.where("category LIKE ?", "%#{value}")
    end
  end

  def partical(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}%")
    elsif model == 'book'
      Book.where("category LIKE ?", "%#{value}%")
    end
  end

  def search_for(how, model, value)
    case how
    when 'perfect_match'
      perfect_match(model, value)
    when 'forward'
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partical'
      partical(model, value)
    end
  end
end
