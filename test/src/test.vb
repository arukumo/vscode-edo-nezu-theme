Imports System
Imports System.Collections.Generic
Imports System.Linq

''' <summary>
''' 江戸伝統色テーマ - Visual Basic / VB.NET 構文解析検証
''' 大文字小文字非依存キーワード（Sub, Function, Dim）、LINQ、モジュール構文の確認用
''' </summary>
Module ModuleTestTheme

    Public Class TraditionalColor
        Public Property Id As Integer
        Public Property Name As String
        Public Property HexCode As String
        Public Property IsReceding As Boolean

        Public Sub New(id As Integer, name As String, hex As String, receding As Boolean)
            Me.Id = id
            Me.Name = name
            Me.HexCode = hex
            Me.IsReceding = receding
        End Sub
    End Class

    Sub Main()
        Dim colors As New List(Of TraditionalColor) From {
            New TraditionalColor(1, "白鼠", "#dcdddd", False),
            New TraditionalColor(2, "舛花色", "#567a98", True),
            New TraditionalColor(3, "江戸茶", "#cd8c5c", False)
        }

        ' LINQ クエリ構文
        Dim query = From c In colors
                    Where c.Id > 0
                    Order By c.Name
                    Select String.Format("色名: {0} ({1})", c.Name, c.HexCode)

        For Each item In query
            Console.WriteLine(item)
        Next
    End Sub

End Module
