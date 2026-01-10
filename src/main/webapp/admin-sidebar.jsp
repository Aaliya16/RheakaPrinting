<%-- admin-sidebar.jsp --%>
<style>
    /* Reset and Sidebar Base */
    .sidebar {
        position: fixed; left: 0; top: 0; width: 260px; height: 100vh;
        background: linear-gradient(180deg, #1e3c72 0%, #2a5298 100%);
        color: white; z-index: 1000; overflow-y: auto;
        box-shadow: 4px 0 10px rgba(0,0,0,0.1);
    }

    /* Branding Header */
    .sidebar-header {
        text-align: center; padding: 30px 20px;
        border-bottom: 1px solid rgba(255,255,255,0.1);
        background: rgba(0,0,0,0.2);
    }
    .sidebar-header i { font-size: 48px; color: #3498db; margin-bottom: 10px; }
    .sidebar-header h2 { font-size: 24px; font-weight: 600; margin: 0; }
    .sidebar-header p { font-size: 13px; color: #bdc3c7; margin-top: 5px; font-weight: 300; }

    /* Sidebar Active State */
    .sidebar-link.active {
        background: rgba(108, 92, 231, 0.1); /* Light purple highlight */
        color: #6c5ce7; /* Brand purple text */
        border-left: 4px solid #6c5ce7; /* Distinct vertical bar */
        font-weight: 700;
    }

    /* Navigation Links */
    .nav-menu { list-style: none; padding: 20px 0; margin: 0; }
    .nav-item { width: 100%; }
    .nav-link {
        display: flex; align-items: center; gap: 15px; padding: 15px 25px;
        color: #ecf0f1; text-decoration: none; transition: 0.3s;
        border-left: 4px solid transparent;
    }

    /* Hover and Active States */
    .nav-link:hover { background: rgba(52, 152, 219, 0.15); border-left-color: #3498db; padding-left: 30px; }
    .nav-link.active {
        background: rgba(52, 152, 219, 0.25);
        border-left-color: #3498db;
        color: white; font-weight: 500;
    }
    .nav-icon { font-size: 18px; width: 25px; text-align: center; }
</style>

<div class="sidebar">
    <div class="sidebar-header">
        <i class="fas fa-shield-alt"></i>
        <h2>ADMIN PANEL</h2>
        <p>Rheaka Printing Management</p>
    </div>
    <ul class="nav-menu">
        <li class="nav-item">
            <a href="<%= request.getContextPath() %>/admin_dashboard.jsp" class="nav-link">
                <i class="fas fa-chart-line nav-icon"></i><span>Dashboard</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="<%= request.getContextPath() %>/admin-orders.jsp" class="nav-link">
                <i class="fas fa-box nav-icon"></i><span>Orders</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="<%= request.getContextPath() %>/admin-products.jsp" class="nav-link">
                <i class="fas fa-tags nav-icon"></i><span>Products</span>
            </a>
        </li>

        <li class="nav-item">
            <a href="<%= request.getContextPath() %>/admin-users.jsp" class="nav-link">
                <i class="fas fa-users nav-icon"></i><span>Users</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="<%= request.getContextPath() %>/admin-contact-messages.jsp" class="nav-link">
                <i class="fas fa-envelope nav-icon"></i><span>Messages</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="<%= request.getContextPath() %>/admin-settings.jsp" class="nav-link">
                <i class="fas fa-cog nav-icon"></i><span>Settings</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="javascript:void(0);" onclick="confirmAdminLogout()" class="nav-link" style="margin-top: 30px; color: #ff7675;">
                <i class="fas fa-sign-out-alt nav-icon"></i><span>Logout</span>
            </a>
        </li>
    </ul>
</div>

<script>
    // Automatically set the "active" class based on current URL
    document.addEventListener("DOMContentLoaded", function() {
        const currentPath = window.location.pathname.split("/").pop();
        document.querySelectorAll('.nav-link').forEach(link => {
            if (link.getAttribute('href') === currentPath) {
                link.classList.add('active');
            }
        });
    });

    // Reusable Logout Logic
    function confirmAdminLogout() {
        if (confirm("Are you sure you want to log out from the Admin Panel?")) {
            // FIXED: Using Context Path and matching the Servlet name exactly
            window.location.href = "<%= request.getContextPath() %>/LogoutServlet";
        }
    }
</script>
}