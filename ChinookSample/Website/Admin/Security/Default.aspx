﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Security_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="row jumbotron">
        <h1>User and Role Administration</h1>
    </div>

    <div class="row">
        <div class="col-md-12">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs">
                <li class="active"><a href="#users" data-toggle="tab">Users</a></li>
                <li><a href="#roles" data-toggle="tab">Roles</a></li>
                <li><a href="#unregistered" data-toggle="tab">Unregistered Users</a></li>
            </ul>
            <!-- tab content area -->
            <div class="tab-content">
                <!-- user tab -->
                <div class="tab-pane fade in active" id="users">
                    <h1>Users</h1>
                     <asp:ListView ID="UserListView" runat="server" 
                        DataSourceID="UserListViewODS"
                         InsertItemPosition="LastItem"
                         ItemType="ChinookSystem.Security.UserProfile"
                         DataKeyNames="UserId"
                         OnItemInserting="UserListView_ItemInserting"
                         OnItemDeleted="RefreshAll"
                         OnItemInserted="RefreshAll">
                        <EmptyDataTemplate>
                            <span>No Security users have been set up.</span>
                        </EmptyDataTemplate>
                        <LayoutTemplate>
                            <div class="row bginfo">
                                <div class="col-sm-2 h4">Action</div>
                                <div class="col-sm-2 h4">User Names</div>
                                <div class="col-sm-5 h4">Profile</div>
                                <div class="col-sm-3 h4">Roles</div>
                            </div>
                            <div runat="server" id="itemPlaceHolder">
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="row">
                                <div class="col-sm-2">
                                    <asp:LinkButton ID="RemoveUser" runat="server" 
                                        CommandName="Delete">Remove</asp:LinkButton>
                                </div>
                                <div class="col-sm-2">
                                   <%# Item.UserName %>
                                </div>
                                <div class="col-sm-5">
                                   <%# Item.Email %>&nbsp;&nbsp;
                                   <%# Item.FirstName + " " + Item.LastName %>
                                </div>
                                <div class="col-sm-3">
                                    <asp:Repeater ID="RoleUserReapter" runat="server"
                                        DataSource="<%# Item.RoleMemberships%>"
                                        ItemType="System.String">
                                        <ItemTemplate>
                                             <%# Item %>
                                        </ItemTemplate>
                                        <SeparatorTemplate>, </SeparatorTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <div class="row">
                                <div class="col-sm-2">
                                    <asp:LinkButton ID="InsertUser" runat="server" 
                                    CommandName="Insert">Insert</asp:LinkButton>
                                    <asp:LinkButton ID="CancelButton" runat="server" 
                                    CommandName="Cancel">Cancel</asp:LinkButton>
                                </div>
                                <div class="col-sm-2">
                                    <asp:TextBox ID="UserName" runat="server"
                                        text='<%# BindItem.UserName %>' 
                                        placeholder="User Name"></asp:TextBox>
                                </div>
                                 <div class="col-sm-5">
                                    <asp:TextBox ID="UserEmail" runat="server"
                                        text='<%# BindItem.Email %>' TextMode="Email" 
                                        placeholder="User Email"></asp:TextBox>
                                </div>
                                <div class="col-sm-3">
                                    <asp:CheckBoxList ID="RoleMemberships" runat="server"
                                        DataSourceID="RoleNameODS"></asp:CheckBoxList>
                                </div>
                            </div>
                        </InsertItemTemplate>
                    </asp:ListView>
                    <asp:ObjectDataSource ID="UserListViewODS" runat="server" 
                        DataObjectTypeName="ChinookSystem.Security.UserProfile" 
                        DeleteMethod="RemoveUser" 
                        InsertMethod="AddUser" 
                        SelectMethod="ListAllUsers"
                        OldValuesParameterFormatString="original_{0}"  
                        TypeName="ChinookSystem.Security.UserManager">
                    </asp:ObjectDataSource>
                     <asp:ObjectDataSource ID="RoleNameODS" runat="server" 
                        SelectMethod="ListAllRoleNames"
                        OldValuesParameterFormatString="original_{0}"  
                        TypeName="ChinookSystem.Security.RoleManager">
                    </asp:ObjectDataSource>
                </div> <!-- eop -->
                <!-- role tab -->
                <div class="tab-pane fade" id="roles">
                    <!-- DataKeyNames contains the considered pkey field of class that is being used for Insert, Update or Delete -->

                    <!-- RefreshAll will call a generic method in my code behind that will cause the ODS sets to re-bind their data -->
                    <asp:ListView ID="RoleListView" runat="server" 
                        DataSourceID="RoleListViewODS" 
                        ItemType="ChinookSystem.Security.RoleProfile" 
                        InsertItemPosition="LastItem"
                        DataKeyNames="RoleId"
                        OnItemInserted="RefreshAll"
                        OnItemDeleted="RefreshAll">
                        <EmptyItemTemplate>
                            <span>No security roles have been set up.</span>
                        </EmptyItemTemplate>
                        <LayoutTemplate>
                            <div class="row biginfo">
                                <div class="col-sm-3 h4">Action</div>
                                <div class="col-sm-3 h4">RoleName</div>
                                <div class="col-sm-3 h4">Users</div>
                            </div>
                            <div class="row" id="itemPlaceholder" runat="server">
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="row">
                            <div class="col-sm-3">
                                <asp:LinkButton ID="RemoveRole" runat="server"
                                    CommandName="Delete">Remove</asp:LinkButton>
                            </div>
                            <div class="col-sm-3">
                                <%# Item.RoleName %>
                            </div>
                            <div class="col-sm-3">
                                <asp:Repeater ID="RoleUsers" runat="server" DataSource="<%#Item.UserNames %>" ItemType="System.String">
                                    <ItemTemplate>
                                        <%# Item %>
                                    </ItemTemplate>
                                    <SeparatorTemplate>, </SeparatorTemplate>
                                </asp:Repeater>
                            </div>
                            </div>
                        </ItemTemplate>
                        
                        <InsertItemTemplate>
                        <div class="row">
                            <div class="col-sm-3">
                                <asp:LinkButton ID="InsertRole" runat="server"
                                    CommandName="Insert">Insert</asp:LinkButton>&nbsp;&nbsp;
                                <asp:LinkButton ID="Cancel" runat="server">Cancel</asp:LinkButton>
                            </div>
                            <div class="col-sm-3">
                                <asp:TextBox ID="RoleName" runat="server" Text='<%# BindItem.RoleName %>' Placeholder="Role Name"></asp:TextBox>
                            </div>
                        </div>
                        </InsertItemTemplate>
                    </asp:ListView>
                    <asp:ObjectDataSource ID="RoleListViewODS" runat="server" DataObjectTypeName="ChinookSystem.Security.RoleProfile" 
                        DeleteMethod="RemoveRole" InsertMethod="AddRole" OldValuesParameterFormatString="original_{0}" 
                        SelectMethod="ListAllRoles" TypeName="ChinookSystem.Security.RoleManager">
                    </asp:ObjectDataSource>
                </div> <!-- eop -->
                <!-- unregistered tab -->
                <div class="tab-pane fade" id="unregistered">
                    <h1>Unregistered Users</h1>
                    <asp:GridView ID="UnregisteredUsersGridView" runat="server" 
                        AutoGenerateColumns="False" 
                        DataSourceID="UnregisteredUsersODS"
                         DataKeyNames="CustomerEmployeeId"
                         ItemType="ChinookSystem.Security.UnregisteredUserProfile" OnSelectedIndexChanging="UnregisteredUsersGridView_SelectedIndexChanging">
                        <Columns>
                            <asp:CommandField SelectText="Register" ShowSelectButton="True"></asp:CommandField>
                            <asp:BoundField DataField="UserType" HeaderText="UserType" SortExpression="UserType"></asp:BoundField>
                            <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName"></asp:BoundField>
                            <asp:BoundField DataField="Lastname" HeaderText="Lastname" SortExpression="Lastname"></asp:BoundField>
                            <asp:TemplateField HeaderText="AssignedUserName" SortExpression="AssignedUserName">
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("AssignedUserName") %>' 
                                        ID="AssignedUserName"></asp:TextBox>
                                </ItemTemplate>
                               
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="AssignedEmail" SortExpression="AssignedEmail">
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("AssignedEmail") %>' 
                                        ID="AssignedEmail"></asp:TextBox>
                                </ItemTemplate>
                               
                            </asp:TemplateField>

                        </Columns>
                        <EmptyDataTemplate>
                            No unregistered users to process.
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:ObjectDataSource ID="UnregisteredUsersODS" runat="server" 
                        OldValuesParameterFormatString="original_{0}" 
                        SelectMethod="ListAllUnRegisteredUsers" 
                        TypeName="ChinookSystem.Security.UserManager">
                    </asp:ObjectDataSource>
                </div> <!-- eop -->
            </div>
        </div>
    </div>
</asp:Content>

