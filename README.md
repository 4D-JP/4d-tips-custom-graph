# 4d-tips-custom-graph
GRAPHコマンドをカスタマイズする例題

<img width="420" alt="ss" src="https://user-images.githubusercontent.com/1725068/184306236-10ba0a90-c2d7-4316-b857-35f4ba9a3106.png">

## 概要

[GRAPH](https://doc.4d.com/4Dv19R5/4D/19-R5/GRAPH.301-5830605.ja.html)は内部的に[PROCESS 4D TAGS](https://doc.4d.com/4Dv19R5/4D/19-R5/PROCESS-4D-TAGS.301-5831242.ja.html)テンプレートを処理してSVGを出力しています。そのテンプレートはアプリケーション内のResources/GraphTemplatesフォルダーに置かれていますが，プロジェクトの`/RESOURCES/`フォルダーにGraphTemplatesフォルダーがあれば，そちらのほうが優先的に使用されます。

* 共通部

すべてのグラフタイプに共通のコードは*Graph_0_Template.svg*に記述されています。たとえば，凡例（レジェンド）の座標などは，ここで計算されています。

* 問題点

標準テンプレートでは，フォントサイズに基づき，簡易的に凡例（レジェンド）の幅が計算されています。

```4d
$nbChar:=0

If ($graphType#7)
  $nbLoops:=$nbSeries
Else 
  $nbLoops:=$nbValues
End if 

For ($serie;1;$nbLoops)
  $n:=Length:C16($legendLabels{$serie})
  If ($n>$nbChar)
    $nbChar:=$n
  End if 
End for 

$LegendWidth:=(3*$LegendlInternalMarginH)+$LegendBulletWidth+(($nbChar+2)*$LabelsFontWidth)
$LegendHeight:=($nbLoops*$LegendBulletHeight)+(($nbLoops+1)*$LegendBulletGap)
```

日本語の場合，もう少し洗練された計算が必要かもしれません。

```4d
C_LONGINT:C283($tempLabelsWidth; $tempLabelsHeight)
C_TEXT:C284($tempSvg; $tempText)
C_PICTURE:C286($temPict)

If ($graphType#7)
	$nbLoops:=$nbSeries
Else 
	$nbLoops:=$nbValues
End if 

$LabelsFontWidth:=0
$LegendHeight:=0

For ($serie; 1; $nbLoops)
	$tempSvg:=SVG_New
	$rect:=SVG_New_rect($tempSvg; 0.5; 0.5; 0; 0)
	$tempText:=SVG_New_textArea($tempSvg; $legendLabels{$serie})
	DOM SET XML ATTRIBUTE:C866($tempText; "style"; $fontStyle)
	$temPict:=SVG_Export_to_picture($tempSvg; Get XML data source:K45:16)
	PICTURE PROPERTIES:C457($temPict; $tempLabelsWidth; $tempLabelsHeight)

	If ($tempLabelsWidth>$LabelsFontWidth)
		$LabelsFontWidth:=$tempLabelsWidth
	End if 
End for 

$LegendWidth:=(3*$LegendlInternalMarginH)+$LegendBulletWidth+$LabelsFontWidth
$LegendHeight:=($nbLoops*$LegendBulletHeight)+(($nbLoops+1)*$LegendBulletGap)

End if 
```
