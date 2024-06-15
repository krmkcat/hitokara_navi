module MyPagesHelper
  def next_rank(user)
    if user.silver?
      'ゴールド'
    elsif user.bronze?
      'シルバー'
    else
      'ブロンズ'
    end
  end

  def next_rank_color(user)
    if user.silver?
      'text-yellow-300'
    elsif user.bronze?
      'text-slate-300'
    else
      'text-orange-700'
    end
  end
end
