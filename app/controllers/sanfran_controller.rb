class SanfranController < ApplicationController


  def new
    @bail = {}
  end

  def bail_calc
    trials ={"jury" => 5000, "misdemeanor" => 2000, "felony" => "felony"}
    @result = total_calc(trials[params[:trial].downcase], params[:charges], params[:parole])
  end

  def felony_calc(highest, lowest, charges)
    (highest + lowest / 2) / charges
  end


  def recur_calc (trial, charges)
    return 0 if charges == 0
    return trial if charges == 1
    trial/charges + recur_calc(trial, charges-1)
  end

  def total_calc (trial, charges, parole)
    if trial == "felony"
      felony_calc(50000, 15000, charges.to_i)
    else
      recur_calc(trial.to_i, charges.to_i) + recur_calc(1000, parole.to_i)
    end
  end
end
