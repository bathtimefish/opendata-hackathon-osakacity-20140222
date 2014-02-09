###
# jQueryでSPARQLを実行するサンプル
#
# 横浜博物館施設一覧を取得する
# http://lod.ac/wiki/SPARQL%E3%82%B9%E3%83%8B%E3%83%9A%E3%83%83%E3%83%88
#
# 最初は $.ajaxでRDFを取得しようとしたけどCross Orign Policyで弾かれたのでこっちにした
#
###

callback = (result)->
    # 実行結果を一覧表示する
    if result?
        elUl = $('<ul/>')
        for json in result
            elLi = $('<li/>')
            attr =
                href: json.s.uri
                text: json.label
            elA = $('<a/>', attr)
            elLi.append elA
            elUl.append elLi
        $('#result').append elUl

main = ()->
    # SPARQLを実行する
    $.sparql('http://lod.ac/sparql')
        .prefix('foaf', 'http://xmlns.com/foaf/0.1/')
        .prefix('rdfs', 'http://www.w3.org/2000/01/rdf-schema#')
        .select(['*'])
        .where('?s', 'a', 'foaf:Organization')
        .where('rdfs:label', '?label')
        .limit(100)
        .execute(callback)

$('button#run').click(()->
    main()
)
