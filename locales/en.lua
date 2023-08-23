local Translations = {
    error = {
        notenough = 'You don\'t have that much %{value1} on you!',
        donthaveany = 'You don\'t have any %{value1} item on you!',
        negativevalue = 'must not be a negative value!',
    },
    success = {
        yousold = 'You sold %{value1} %{value2} for $%{value3}',
    },
    print = {
        cyclecomplete = 'Market Trader Cycle Complete',
    },
    inputmenu = {
        header = 'Enter the number of %{value1} 1pc / %{value2} $',
        submittext = 'sell',
        imputstext = '%{value1} Amount',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
