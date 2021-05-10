TypeOfSmoker2.fun <- function(smokingstat, lessdaily, pastsmoke) {
  if (is.na(smokingstat) | smokingstat == 'A2' &
      is.na(lessdaily) | smokingstat == 'A3' &
      is.na(pastsmoke)) {
    return("NA::a")
  }
  # Current daily smoker
  else if (smokingstat == 'A1') {
    return(1)
  }
  # Current occasional smoker - daily in past
  else if (TypeOfSmoker2 == 'A2' & lessdaily == 'yless') {
    return(2)
  }
  # Current occasional smoker - never daily
  else if (smokingstat == 'A2' & lessdaily == 'nless') {
    return(3)
  }
  # Former smoker - daily in past
  else if (smokingstat == 'A3' & pastsmoke == 'dal') {
    return(4)
  }
  # Former smoker - never daily
  else if (smokingstat == 'A3' & pastsmoke == 'dal2') {
    return(5)
  } else {
    return(6)
  }
}

SmokeSimple.fun <- function(TypeOfSmoker2, tsq5) {
  if (is.na(TypeOfSmoker2) |
      (TypeOfSmoker2 == 4 &
       is.na(tsq5)) | (TypeOfSmoker2 == 5 & is.na(tsq5))) {
    return("NA::a")
  }
  else if (TypeOfSmoker2 == 6) {
    return(1)
  }
  else if ((TypeOfSmoker2 == 4 &
            tsq5 == 'more5') | (TypeOfSmoker2 == 5
                                &
                                tsq5 == 'more5')) {
    return(2)
  } else if ((TypeOfSmoker2 == 4 & tsq5 == 'less5')
             | (TypeOfSmoker2 == 4 & tsq5 == 'less5')) {
    return(3)
  } else {
    return(4)
  }
}


PackYears_cont.fun <-
  function(TypeOfSmoker2,
           Age_cont,
           dailyage,
           dailycig,
           stopdaily,
           dailyage2,
           dailycig3,
           stopdaily2,
           dailyage3,
           dailycig4) {
    if ((
      is.na(TypeOfSmoker2) |
      TypeOfSmoker2 == 1 & (is.na(dailyage) | is.na(dailycig))
      |
      TypeOfSmoker2 == 2 &
      (is.na(stopdaily) | is.na(dailyage2) | is.na(dailycig3))
      |
      TypeOfSmoker2 == 4 &
      (is.na(stopdaily2) | is.na(dailyage3) | is.na(dailycig4))
    )) {
      return(NA)
    } else if (TypeOfSmoker2 == 1) {
      return((Age_cont - dailyage) * (dailycig / 20))
    } else if (TypeOfSmoker2 == 2) {
      return((stopdaily - dailyage2) * (dailycig3 / 20))
    } else if (TypeOfSmoker2 == 3) {
      return(0)
    } else if (TypeOfSmoker2 == 4) {
      return((stopdaily2 - dailyage3) * (dailycig4 / 20))
    } else {
      return(0)
    }
  }

FormerDrinker.fun <- function(drk, evdk) {
  if (is.na(drk)) {
    return("NA::a")
  } else if (drk == 0 & evdk == 'evdk2') {
    return(1)
  } else if (drk == 0 & evdk == 'evdk1') {
    return(2)
  } else {
    return("NA::a")
  }
}

FruitVeg_cont.fun <- function(fv_fruit1, fv_veg1) {
  return((fv_fruit1 + fv_veg1) / 7)
}

Potato_cont.fun <- function(fv_pot1) {
  return(fv_pot1 / 7)
}

Juice_cont.fun <- function(fv_juice1) {
  return(fv_juice1 / 7)
}

PhysicalActivity_cont.fun <- function(vigact, modact, ligact) {
  vig <- 0
  if (!is.na(vigact)) {
    vig <- vigact
  }
  
  mod <- 0
  if (!is.na(modact)) {
    mod <- modact
  }
  
  ligact <- 0
  if (!is.na(ligact)) {
    lig <- ligact
  }
  
  if (is.na(vigact) & is.na(modact) & is.na(ligact)) {
    return("NA::a")
  } else {
    return((((vig / 7) * 8) + ((mod / 7) * 5) + ((lig / 7) * 3)))
  }
}

NeedHelp.fun <-
  function(needhelp_meals,
           needhelp_errands,
           needhelp_hw,
           needhelp_pcare,
           needhelp_mov,
           needhelp_fina,
           needhelp_none) {
    meals <- NA
    if (needhelp_meals == "Y") {
      meals <- 1
    } else if (needhelp_meals == "N") {
      meals <- 0
    }
    
    errands <- NA
    if (needhelp_errands == "Y") {
      errands <- 1
    } else if (needhelp_errands == "N") {
      errands <- 0
    }
    
    hw <- NA
    if (needhelp_hw == "Y") {
      hw <- 1
    } else if (needhelp_hw == "N") {
      hw <- 0
    }
    
    pcare <- NA
    if (needhelp_pcare == "Y") {
      pcare <- 1
    } else if (needhelp_pcare == "N") {
      pcare <- 0
    }
    
    mov <- NA
    if (needhelp_mov == "Y") {
      mov <- 1
    } else if (needhelp_mov == "N") {
      mov <- 0
    }
    
    fina <- NA
    if (needhelp_fina == "Y") {
      fina <- 1
    } else if (needhelp_fina == "N") {
      fina <- 0
    }
    
    if (needhelp_none == "Y") {
      return(0)
    } else {
      return(sum(meals + errands + hw + pcare + mov + fina))
    }
  }

BMI_cont.fun <-
  function(lbs,
           kgs,
           cm,
           feetinches_feet,
           feetinches_inches) {
    missing_bmi <- FALSE
    if ((is.na(lbs) &
         is.na(kgs)) |
        (is.na(feetinches_feet) | is.na(feetinches_inches))) {
      missing_bmi <- TRUE
    }
    
    formatted_kgs <- kgs
    if (missing_bmi == TRUE) {
      formatted_kgs <- NA
    } else if (is.na(kgs)) {
      formatted_kgs <- NA
    } else {
      formatted_kgs <- round((lbs / 2.2046), 2)
    }
    
    metres <- NA
    if (missing_bmi) {
      metres <- NA
    } else if (is.na(cm)) {
      metres <-
        (round((
          feetinches_feet * 30.48 + feetinches_inches * 2.54
        ), 2)) / 100
    } else {
      metres <- cm / 100
    }
    
    return(kgs / (metres * metres))
  }