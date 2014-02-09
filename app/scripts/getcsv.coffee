###
# 大阪市の施設情報ポイントデータをパースする
#
###

successCallback = (data)->
    rows = $.csv.toArrays(data)
    attr =
        border: 1
    elTable = $('<table/>', attr)
    for row in rows
        elTr = $('<tr/>')
        for col in row
            attr =
                text: col
            elTd = $('<td/>', attr)
            elTd.appendTo(elTr)
        elTr.appendTo(elTable)
    elTable.appendTo($('#result'))

errorCallback = (data)->
    console.log data

beforeSendCallback = (xhr)->
    xhr.overrideMimeType("text/html;charset=Shift_JIS")

main = ()->
    options =
        # CSVも同一生成元ポリシーにひっかかって取得できない。。
        #url: 'http://www.city.osaka.lg.jp/contents/wdu090/opendata/mapnavoskdat_csv/mapnavoskdat_kankouchou.csv'
        # 上記データをSame Originに置いてみた
        #url: 'http://www.bathtimefish.com/html5/opendata/mapnavoskdat_kankouchou.csv'
        # ローカルテスト用
        url: '/opendata/mapnavoskdat_kankouchou.csv'
        async: true
        cache: false
        dataType: 'text'
        beforeSend: beforeSendCallback

    $.ajax(options)
        .done(successCallback)
        .fail(errorCallback)

$('button#run').click(()->
    main()
)
