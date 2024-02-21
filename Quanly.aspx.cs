using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BanhangWeb
{
    public partial class Quanly : System.Web.UI.Page
    {
        int SP_ID;
        //SqlConnection myCon = new SqlConnection(ConfigurationManager.ConnectionStrings["ShopConnection"].ConnectionString);
        SqlConnection myCon;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DoGridView();
            }
        }
        private void DoGridView()
        {
            try
            {
                myCon = DBClass.OpenConn();
                int nhomID = 0;
                if (ListNhom.SelectedIndex > -1)
                {
                    nhomID = Convert.ToInt32(ListNhom.SelectedItem.Value);
                }
                using (SqlCommand myCom = new SqlCommand("dbo.usp_GetProducts", myCon))
                {
                    myCom.Parameters.Add("@NhomID", sqlDbType: SqlDbType.VarChar).Value = nhomID;
                    myCom.Connection = myCon;
                    myCom.CommandType = CommandType.StoredProcedure;

                    SqlDataReader myDr = myCom.ExecuteReader();

                    gvSanphams.DataSource = myDr;
                    gvSanphams.DataBind();

                    myDr.Close();
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in Sanpham doGridView: " + ex.Message; }
            finally { myCon.Close(); }
        }
        protected void lbNewSanpham_Click(object sender, EventArgs e)
        {
            try
            {
                txtSanphamName.Text = "";
                txtSanphamMa.Text = "";
                txtSanphamDVT.Text = "";
                txtDongia.Text = "";

                lblSanphamNew.Visible = true;
                lblSanphamUpd.Visible = false;
                btnAddSanpham.Visible = true;
                btnUpdSanpham.Visible = false;

                GetNhomForDLL();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openSPDetail();", true);
            }
            catch (Exception) { throw; }
        }
        protected void btnAddSanpham_Click(object sender, EventArgs e)
        {
            try
            {
                myCon = DBClass.OpenConn();
                using (SqlCommand myCom = new SqlCommand("dbo.usp_InsSanpham", myCon))
                {
                    myCom.CommandType = CommandType.StoredProcedure;
                    myCom.Parameters.Add("@TenSP", SqlDbType.NVarChar).Value = txtSanphamName.Text;
                    myCom.Parameters.Add("@MaSP", SqlDbType.NVarChar).Value = txtSanphamMa.Text;
                    myCom.Parameters.Add("@Dvt", SqlDbType.NVarChar).Value = txtSanphamDVT.Text;
                    myCom.Parameters.Add("@Gia", SqlDbType.Decimal).Value = decimal.Parse(txtDongia.Text);
                    myCom.Parameters.Add("@NhomID", SqlDbType.Int).Value = int.Parse(ddlNhom.SelectedValue);

                    myCom.ExecuteNonQuery();
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in btnAddSanpham_Click: " + ex.Message; }
            finally { myCon.Close(); }
            DoGridView();
        }
        protected void btnUpdSanpham_Click(object sender, EventArgs e)
        {
            UpdSanpham();
            DoGridView();
        }
        protected void gvSanphams_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdSanpham")
            {
                SP_ID = Convert.ToInt32(e.CommandArgument);


                txtSanphamName.Text = "";
                txtSanphamMa.Text = "";
                txtSanphamDVT.Text = "";
                txtDongia.Text = "";

                lblSanphamNew.Visible = false;
                lblSanphamUpd.Visible = true;
                btnAddSanpham.Visible = false;
                btnUpdSanpham.Visible = true;
                GetNhomForDLL();
                GetSanpham(SP_ID);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openSPDetail();", true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "LaunchServerSide", "$(function() { openSPDetail(); });", true);
            }
        }
        private void GetNhomForDLL()
        {
            try
            {
                myCon = DBClass.OpenConn();
                using (SqlCommand cmd = new SqlCommand("dbo.usp_GetNhoms", myCon))
                {
                    SqlDataReader myDr = cmd.ExecuteReader();

                    ddlNhom.DataSource = myDr;
                    ddlNhom.DataTextField = "Tennhom";
                    ddlNhom.DataValueField = "Manhom";
                    ddlNhom.DataBind();
                    ddlNhom.Items.Insert(0, new ListItem("-- Chọn nhóm --", "0"));

                    myDr.Close();
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in GetNhomForDLL: " + ex.Message; }
            finally { myCon.Close(); }
        }

        protected void gvSanphams_RowDeleting(Object sender, GridViewDeleteEventArgs e)
        {
            SP_ID = Convert.ToInt32(gvSanphams.DataKeys[e.RowIndex].Value.ToString());

            try
            {
                //myCon.Open();
                myCon = DBClass.OpenConn();
                using (SqlCommand cmd = new SqlCommand("dbo.usp_DelSanpham", myCon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ID", SqlDbType.Int).Value = SP_ID;
                    cmd.ExecuteScalar();
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in gvSanphams_RowDeleting: " + ex.Message; }
            finally { myCon.Close(); }
            DoGridView();
        }
        private void GetSanpham(int Comp_ID)
        {
            try
            {
                myCon = DBClass.OpenConn();
                using (SqlCommand myCmd = new SqlCommand("dbo.usp_GetSanpham", myCon))
                {
                    myCmd.Connection = myCon;
                    myCmd.CommandType = CommandType.StoredProcedure;
                    myCmd.Parameters.Add("@ID", SqlDbType.Int).Value = Comp_ID;
                    SqlDataReader myDr = myCmd.ExecuteReader();

                    if (myDr.HasRows)
                    {
                        while (myDr.Read())
                        {
                            txtSanphamName.Text = myDr.GetValue(1).ToString();
                            txtSanphamMa.Text = myDr.GetValue(2).ToString();
                            txtSanphamDVT.Text = myDr.GetValue(3).ToString();
                            txtDongia.Text = myDr.GetValue(4).ToString();
                            ddlNhom.SelectedValue = myDr.GetValue(6).ToString();
                            lblSPID.Text = Comp_ID.ToString();
                        }
                    }
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in GetSanpham: " + ex.Message; }
            finally { myCon.Close(); }
        }
        private void UpdSanpham()
        {
            try
            {
                myCon = DBClass.OpenConn();
                using (SqlCommand cmd = new SqlCommand("dbo.usp_UpdSanpham", myCon))
                {
                    cmd.Connection = myCon;
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@ID", SqlDbType.Int).Value = int.Parse(lblSPID.Text);
                    cmd.Parameters.Add("@TenSP", SqlDbType.NVarChar).Value = txtSanphamName.Text;
                    cmd.Parameters.Add("@MaSP", SqlDbType.NVarChar).Value = txtSanphamMa.Text;
                    cmd.Parameters.Add("@Dvt", SqlDbType.NVarChar).Value = txtSanphamDVT.Text;
                    cmd.Parameters.Add("@Gia", SqlDbType.Decimal).Value = txtDongia.Text;
                    cmd.Parameters.Add("@NhomID", SqlDbType.Int).Value = ddlNhom.SelectedValue;


                    int rows = cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in UpdSanpham: " + ex.Message; }
            finally { myCon.Close(); }
        }

        protected void ShowNhom(object sender, EventArgs e)
        {
            // Get the currently selected item in the ListBox.
            //string curItem = ListNhom.SelectedItem.ToString();
            DoGridView();

        }
    }
}