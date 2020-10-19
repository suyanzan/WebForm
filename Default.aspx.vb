
Partial Class _Default
    Inherits System.Web.UI.Page
    <System.Web.Services.WebMethod()> _
    Public Shared Function GetFileName(ByVal DPF As String, ByVal CHECKSUM As String) As String
        Try
            Throw New Exception("Exception Occured")
            Return "Hello " & DPF & CHECKSUM & Environment.NewLine & "The Current Time is: " & _
            DateTime.Now.ToString()
        Catch ex As Exception
            Throw New Exception(ex.Message.ToString)
        End Try
    End Function
End Class
