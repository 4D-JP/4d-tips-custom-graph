//%attributes = {}
////////// グラフサンプルコード（ここから）//////////
//グラフデータを作成
$max:=10
ARRAY TEXT:C222($X; $max)  // X軸の配列を作成
ARRAY REAL:C219($A; $max)  // Y軸の配列を作成
ARRAY REAL:C219($B; $max)  // Y軸の配列を作成
For ($i; 1; $max)
	$X{$i}:=String:C10($i+1920)
	$A{$i}:=Random:C100
	$B{$i}:=Random:C100
End for 
$settings:=New object:C1471
$settings.graphType:=4  //線グラフ
$settings.defaultWidth:=500  //横幅
$settings.legendLabels:=New collection:C1472("長いレジェンド名A"; "長いレジェンド名B")
GRAPH:C169($Graph; $settings; $X; $A; $B)  // グラフ描画
//フォームを作成
$objects:=New object:C1471
$objects["Graph area"]:=New object:C1471(\
"type"; "input"; \
"top"; 20; "left"; 20; "width"; 800; "height"; 500; \
"dataSource"; "Form.graph"; \
"dataSourceTypeHint"; "picture"; \
"scrollbarHorizontal"; "visible"; \
"enterable"; False:C215; \
"focusable"; False:C215)
$df:=New object:C1471("rightMargin"; 20; "bottomMargin"; 20; "destination"; "detailScreen"; "windowTitle"; "グラフサンプル")
$df.pages:=New collection:C1472(New object:C1471; New object:C1471("objects"; $objects))
//フォームを表示
$ref:=Open form window:C675($df)
DIALOG:C40($df; New object:C1471("graph"; $Graph))  //グラフデータをフォームに引き継ぐ
CLOSE WINDOW:C154($ref)
////////// グラフサンプルコード（ここまで）//////////