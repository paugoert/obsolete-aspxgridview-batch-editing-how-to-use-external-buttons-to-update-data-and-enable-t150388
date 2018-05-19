<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function OnBatchEditStartEditing(s, e) {
            ToggleButtons(true);
        }
        function OnBatchEditEndEditing(s, e) {
            window.setTimeout(function () {
                if (!s.batchEditApi.HasChanges())
                    ToggleButtons(false);
            }, 0);
        }
        function ToggleButtons(enabled) {
            btnUpdate.SetEnabled(enabled);
            btnCancel.SetEnabled(enabled);
        }
        function OnUpdateClick(s, e) {
            gridView.UpdateEdit();
            ToggleButtons(false);
        }
        function OnCancelClick(s, e) {
            gridView.CancelEdit();
            ToggleButtons(false);
        }
        function OnCustomButtonClick(s, e) {
            if (e.buttonID == "deleteButton") {
                s.DeleteRow(e.visibleIndex);
                ToggleButtons(true);
            }
        }
        function OnEndCallback(s, e) {
            window.setTimeout(function () {
                if (!s.batchEditApi.HasChanges())
                    ToggleButtons(false);
            }, 0);
        }
    </script>
</head>
<body>
    <form id="frmMain" runat="server">
        <dx:ASPxGridView ID="Grid" runat="server" KeyFieldName="ID" OnBatchUpdate="Grid_BatchUpdate"
            OnRowInserting="Grid_RowInserting" OnRowUpdating="Grid_RowUpdating" OnRowDeleting="Grid_RowDeleting"
            ClientInstanceName="gridView" Theme="DevEx">
            <ClientSideEvents BatchEditEndEditing="OnBatchEditEndEditing" BatchEditStartEditing="OnBatchEditStartEditing"  CustomButtonClick="OnCustomButtonClick" EndCallback="OnEndCallback"/>
            <Columns>
                <dx:GridViewCommandColumn>
                    <CustomButtons>
                        <dx:GridViewCommandColumnCustomButton ID="deleteButton" Text="Delete">
                        </dx:GridViewCommandColumnCustomButton>
                    </CustomButtons>
                </dx:GridViewCommandColumn>
                <dx:GridViewDataColumn FieldName="C1" />
                <dx:GridViewDataSpinEditColumn FieldName="C2" />
                <dx:GridViewDataTextColumn FieldName="C3" />
                <dx:GridViewDataCheckColumn FieldName="C4" />
                <dx:GridViewDataDateColumn FieldName="C5" />
            </Columns>
            <SettingsEditing Mode="Batch" />
            <Settings ShowStatusBar="Hidden" />
        </dx:ASPxGridView>
        <br />
        <dx:ASPxButton ID="btnUpdate" runat="server" Text="Update" ClientInstanceName="btnUpdate" AutoPostBack="false" ClientEnabled="false">
            <ClientSideEvents Click="OnUpdateClick" />
        </dx:ASPxButton>
        <dx:ASPxButton ID="btnCancel" runat="server" Text="Cancel" ClientInstanceName="btnCancel" AutoPostBack="false" ClientEnabled="false">
            <ClientSideEvents Click="OnCancelClick" />
        </dx:ASPxButton>
    </form>
</body>
</html>