<%@ Page Title="Trang chu" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="BanhangWeb._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script type="text/javascript">
            function openSPDetail() {
                //alert("Opening modal!");
                //jQuery.noConflict();
                $('#modSPDetail').modal('show');
            }
            function openGiohang() {
                //alert("Opening modal!");
                //jQuery.noConflict();
                $('#ListGiohang').modal('show');
            }
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Noidung" runat="server">
    <div class="container">
        <div class="col-sm-4">
            <asp:Label ID="lblMessage" runat="server" Text="" />
        </div>
        <div class="col-sm-4" style="text-align: right;">
            <asp:Label ID="Label5" runat="server" Text="[" Font-Size="12px" Visible="true"></asp:Label>
            <asp:LinkButton ID="lbGiohang" runat="server" Font-Size="12px" OnClick="lbGiohang_Click" Text="Giỏ hàng"> </asp:LinkButton>
            <asp:Label ID="Label6" runat="server" Text="]" Font-Size="12px" Visible="true"></asp:Label>
        </div>
        <%-- Gridview --%>
        <div class="row" style="margin-top: 20px;">
            <div class="col-sm-2">
                <asp:ListBox ID="ListNhom" runat="server" DataSourceID="SqlDataSource1" Width="100%"
                DataTextField="Tennhom" DataValueField="Manhom" AutoPostBack="true" OnSelectedIndexChanged="ShowNhom"></asp:ListBox>  
                <asp:SqlDataSource ID="SqlDataSource1" runat="server"   
                ConnectionString="<%$ ConnectionStrings:ShopConnection %>"   
                SelectCommand="SELECT * FROM NhomSP"></asp:SqlDataSource>                
            </div>
            <div class="col-sm-8">
                <asp:GridView ID="listSanphams" runat="server" AutoGenerateColumns="False" AllowSorting="True" 
                    DataKeyNames="IDSP"
                    CssClass="table table-striped table-bordered table-condensed" BorderColor="Silver"
                    OnRowCommand="listSanphams_RowCommand"
                    EmptyDataText="Không có dữ liệu trong nhóm">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" Width="25px" />
                            <ItemStyle HorizontalAlign="Left" Font-Bold="true" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="image">
                                <ItemTemplate>
                                    <asp:Image ID="img" runat="server" Width="100px" Height="100px" imageurl='<%#  "~/Images/"+Eval("img") %>'/>
                                </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="Tennhom" HeaderText="Nhóm">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="MaSP" HeaderText="Mã">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TenSP" HeaderText="Tên sản phẩm">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Dvt" HeaderText="ĐVT">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Giaban" HeaderText="Giá bán" DataFormatString="{0:### ### ###}" >
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <%-- Update Company --%>
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:LinkButton ID="lbChitietSanpham" runat="server" CommandArgument='<%# Eval("IDSP") %>'
                                    CommandName="XemSanpham" Text="Xem" CausesValidation="false"></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="80px" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <!-- Modal to View a Sanpham Details-->
        <div class="modal fade" id="modSPDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" style="width: 600px;">
                <div class="modal-content" style="font-size: 11px;">

                    <div class="modal-header" style="text-align: center;">
                        <asp:Label ID="lblSanphamXem" runat="server" Text="Chi tiết sản phẩm" Font-Size="24px" Font-Bold="true" />
                    </div>

                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">

                                <%-- Sanpham Details Textboxes --%>
                                <div class="col-sm-12">
                                    <div class="row" style="margin-top: 20px;">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:Image ID="Image1" runat="server" Width="500px" Height="500px"/>
                                        </div>
                                        <div class="col-sm-1"></div>
                                    </div>

                                    <div class="row" style="margin-top: 20px;">

                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtSanphamName" runat="server" MaxLength="255" CssClass="form-control input-xs" 
                                                ToolTip="Tên sản phẩm"
                                                AutoCompleteType="Disabled" placeholder="Tên sản phẩm" />
                                            <asp:Label runat="server" ID="lblSPID" Visible="false" Font-Size="12px" />
                                        </div>
                                        <div class="col-sm-1">
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 20px;">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtSanphamMa" runat="server" MaxLength="255" CssClass="form-control input-xs" 
                                                ToolTip="Mã sản phẩm"
                                                AutoCompleteType="Disabled" placeholder="Mã sản phẩm" />
                                        </div>
                                        <div class="col-sm-1">
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 20px;">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtSanphamDVT" runat="server" MaxLength="255" CssClass="form-control input-xs" 
                                                ToolTip="Đơn vị tính"
                                                AutoCompleteType="Disabled" placeholder="Đơn vị tính" />
                                        </div>
                                        <div class="col-sm-1">
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 20px;">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtDongia" runat="server" MaxLength="255" CssClass="form-control input-xs" 
                                                ToolTip="Giá bán"
                                                AutoCompleteType="Disabled" placeholder="Giá bán sản phẩm" />
                                        </div>
                                        <div class="col-sm-1">
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <%-- Message label on modal page --%>
                        <div class="row" style="margin-top: 20px; margin-bottom: 10px;">
                            <div class="col-sm-1"></div>
                            <div class="col-sm-10">
                                <asp:Label ID="Label1" runat="server" ForeColor="Red" Font-Size="12px" Text="" />
                            </div>
                            <div class="col-sm-1"></div>
                        </div>
                    </div>

                    <%-- Chon hang Buttons --%>
                    <div class="modal-footer">
                        <asp:Button ID="Button1" runat="server" class="btn btn-danger button-xs" data-dismiss="modal" 
                            Text="Chọn vào giỏ hàng"
                            Visible="true" CausesValidation="false"
                            OnClick="btnChonSanpham_Click"
                            UseSubmitBehavior="false" />
                        <asp:Button ID="Button2" runat="server" class="btn btn-info button-xs" data-dismiss="modal" 
                            Text="Close" CausesValidation="false"
                            UseSubmitBehavior="false" />
                    </div>

                </div>
            </div>
        </div>

        <!-- Modal to View a List gio hang-->
        <div class="modal fade" id="ListGiohang" tabindex="-1" role="dialog" aria-labelledby="myGiohang" aria-hidden="true">
            <div class="modal-dialog modal-lg" style="width: 600px;">
                <div class="modal-content" style="font-size: 11px;">
                    <div class="modal-header" style="text-align: center;">
                        <asp:Label ID="Label2" runat="server" Text="Giỏ hàng" Font-Size="24px" Font-Bold="true" />
                    </div>
                    <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AllowSorting="True" 
                                DataKeyNames="idSP"
                                CssClass="table table-striped table-bordered table-condensed" BorderColor="Silver"
                                OnRowDeleting="GridView1_RowDeleting"
                                EmptyDataText="Không có dữ liệu trong nhóm">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" Width="25px" />
                                        <ItemStyle HorizontalAlign="Left" Font-Bold="true" />
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="TenSP" HeaderText="Tên sản phẩm">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Gia" HeaderText="Giá bán" DataFormatString="{0:### ### ###}" >
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SoLuong" HeaderText="Số lượng" DataFormatString="{0:### ### ###}" >
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="TongTien" HeaderText="Thành tiền" DataFormatString="{0:### ### ###}" >
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>

                                        <%-- Delete Sanpham --%>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbXoaSanpham" Text="Xóa" runat="server"
                                                    OnClientClick="return confirm('Bạn chắc chắn muốn xóa sản phẩm này?');" CommandName="Delete" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                                        </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>

                    <%-- Dat hang Buttons --%>
                    <div class="modal-footer">
                        <asp:Button ID="lbDathang" runat="server" class="btn btn-danger button-xs" data-dismiss="modal" 
                            Text="Đặt hàng"
                            Visible="true" CausesValidation="false"
                            OnClick="btnDathang_Click"
                            UseSubmitBehavior="false" />
                        <asp:Button ID="Button4" runat="server" class="btn btn-info button-xs" data-dismiss="modal" 
                            Text="Close" CausesValidation="false"
                            UseSubmitBehavior="false" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>

</asp:Content>
