<%-- admin-sidebar.jsp --%>
<style>
    /* Base Sidebar - Static position */
    .sidebar {
        position: fixed; left: 0; top: 0; width: 260px; height: 100vh;
        background: linear-gradient(180deg, #1e3c72 0%, #2a5298 100%);
        color: white; z-index: 1000; overflow-y: auto;
        box-shadow: 4px 0 10px rgba(0,0,0,0.1);
    }

    /* Entrance Animation - Only applied via JavaScript on first load */
    .sidebar.animate-in {
        animation: sidebarSlideIn 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
        left: -260px;
        opacity: 0;
    }

    @keyframes sidebarSlideIn {
        from { left: -260px; opacity: 0; }
        to { left: 0; opacity: 1; }
    }

    /* Staggered Links - Only animate if parent has .animate-in class */
    .sidebar.animate-in .nav-item {
        opacity: 0;
        animation: linkFadeIn 0.4s ease-out forwards;
    }

    /* Adjusted staggered delays for 7 items + Logout */
    .sidebar.animate-in .nav-item:nth-child(1) { animation-delay: 0.3s; }
    .sidebar.animate-in .nav-item:nth-child(2) { animation-delay: 0.4s; }
    .sidebar.animate-in .nav-item:nth-child(3) { animation-delay: 0.5s; }
    .sidebar.animate-in .nav-item:nth-child(4) { animation-delay: 0.6s; }
    .sidebar.animate-in .nav-item:nth-child(5) { animation-delay: 0.7s; }
    .sidebar.animate-in .nav-item:nth-child(6) { animation-delay: 0.8s; }
    .sidebar.animate-in .nav-item:nth-child(7) { animation-delay: 0.9s; }
    .sidebar.animate-in .nav-item:nth-child(8) { animation-delay: 1.0s; }

    @keyframes linkFadeIn {
        from { opacity: 0; transform: translateX(-15px); }
        to { opacity: 1; transform: translateX(0); }
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

    /* Navigation Menu */
    .nav-menu { list-style: none; padding: 20px 0; margin: 0; }
    .nav-link {
        display: flex; align-items: center; gap: 15px; padding: 15px 25px;
        color: #ecf0f1; text-decoration: none; transition: 0.3s;
        border-left: 4px solid transparent;
    }

    .nav-link:hover { background: rgba(52, 152, 219, 0.15); border-left-color: #3498db; padding-left: 30px; }

    .nav-link.active {
        background: rgba(52, 152, 219, 0.25);
        border-left-color: #3498db;
        color: white; font-weight: 600;
    }
    .nav-icon { font-size: 18px; width: 25px; text-align: center; }
</style>

<div class="sidebar" id="adminSidebar">
    <div class="sidebar-header">
        <i class="fas fa-shield-alt"></i>
        <h2>ADMIN PANEL</h2>
        <p>Rheaka Printing Management</p>
    </div>
    <ul class="nav-menu">
        <li class="nav-item"><a href="admin_dashboard.jsp" class="nav-link"><i class="fas fa-chart-line nav-icon"></i><span>Dashboard</span></a></li>
        <li class="nav-item"><a href="admin-orders.jsp" class="nav-link"><i class="fas fa-box nav-icon"></i><span>Orders</span></a></li>
        <li class="nav-item"><a href="admin-products.jsp" class="nav-link"><i class="fas fa-tags nav-icon"></i><span>Products</span></a></li>
        <li class="nav-item"><a href="admin-users.jsp" class="nav-link"><i class="fas fa-users nav-icon"></i><span>Users</span></a></li>

        <%-- ADDED: Quote Requests Link --%>
        <li class="nav-item"><a href="admin-quotes.jsp" class="nav-link"><i class="fas fa-file-invoice-dollar nav-icon"></i><span>Quote Requests</span></a></li>

        <li class="nav-item"><a href="admin-contact-messages.jsp" class="nav-link"><i class="fas fa-envelope nav-icon"></i><span>Messages</span></a></li>
        <li class="nav-item"><a href="admin-settings.jsp" class="nav-link"><i class="fas fa-cog nav-icon"></i><span>Settings</span></a></li>
        <li class="nav-item">
            <a href="javascript:void(0);" onclick="confirmAdminLogout()" class="nav-link" style="margin-top: 30px; color: #ff7675;">
                <i class="fas fa-sign-out-alt nav-icon"></i><span>Logout</span>
            </a>
        </li>
    </ul>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const sidebar = document.getElementById("adminSidebar");

        // One-time session animation logic
        if (!sessionStorage.getItem("sidebarAnimated")) {
            sidebar.classList.add("animate-in");
            sessionStorage.setItem("sidebarAnimated", "true");
        }

        // Active Link Highlighting
        const currentPath = window.location.pathname.split("/").pop();
        document.querySelectorAll('.nav-link').forEach(link => {
            if (link.getAttribute('href').includes(currentPath) && currentPath !== "") {
                link.classList.add('active');
            }
        });
    });

    function confirmAdminLogout() {
        if (confirm("Are you sure you want to log out?")) {
            sessionStorage.removeItem("sidebarAnimated"); // Reset for next login
            window.location.href = "<%= request.getContextPath() %>/LogoutServlet";
        }
    }
</script>