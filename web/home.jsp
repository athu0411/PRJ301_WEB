<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>StyleHub - Home</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #f8fbff 0%, #e8f4fd 100%);
                min-height: 100vh;
            }

            /* Header Styles */
            .header {
                background: white;
                box-shadow: 0 2px 20px rgba(168, 209, 232, 0.15);
                position: sticky;
                top: 0;
                z-index: 1000;
            }

            .nav-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                height: 70px;
            }

            .logo {
                font-size: 1.8rem;
                font-weight: bold;
                color: #5a9bd4;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .nav-menu {
                display: flex;
                list-style: none;
                gap: 30px;
            }

            .nav-menu a {
                text-decoration: none;
                color: #374151;
                font-weight: 500;
                transition: color 0.3s ease;
                padding: 10px 0;
            }

            .nav-menu a:hover {
                color: #5a9bd4;
            }

            .user-menu {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .welcome-text {
                color: #6b7280;
                font-size: 0.9rem;
            }

            .username {
                color: #5a9bd4;
                font-weight: 600;
            }

            .cart-icon {
                background: #5a9bd4;
                color: white;
                border: none;
                padding: 10px;
                border-radius: 50%;
                cursor: pointer;
                font-size: 1.1rem;
                transition: all 0.3s ease;
                position: relative;
            }

            .cart-icon:hover {
                background: #4a8bc2;
                transform: scale(1.1);
            }

            .cart-count {
                position: absolute;
                top: -5px;
                right: -5px;
                background: #ef4444;
                color: white;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                font-size: 0.7rem;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .logout-btn {
                background: transparent;
                border: 2px solid #5a9bd4;
                color: #5a9bd4;
                padding: 8px 16px;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .logout-btn:hover {
                background: #5a9bd4;
                color: white;
            }

            /* Main Content */
            .main-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 40px 20px;
            }

            .hero-section {
                text-align: center;
                margin-bottom: 50px;
            }

            .hero-section h1 {
                color: #374151;
                font-size: 2.5rem;
                margin-bottom: 15px;
                font-weight: 700;
            }

            .hero-section p {
                color: #6b7280;
                font-size: 1.1rem;
                max-width: 600px;
                margin: 0 auto;
            }

            /* Filter Section */
            .filter-section {
                background: white;
                border-radius: 15px;
                padding: 25px;
                margin-bottom: 40px;
                box-shadow: 0 5px 20px rgba(168, 209, 232, 0.1);
            }

            .filter-container {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
                align-items: center;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }

            .filter-group label {
                font-size: 0.9rem;
                color: #374151;
                font-weight: 500;
            }

            .filter-group select {
                padding: 10px 15px;
                border: 2px solid #e5f3ff;
                border-radius: 8px;
                font-size: 0.9rem;
                background: #fafcff;
                color: #374151;
                cursor: pointer;
                transition: border-color 0.3s ease;
            }

            .filter-group select:focus {
                outline: none;
                border-color: #a8d1e8;
            }

            /* Product Grid */
            .products-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 30px;
                margin-bottom: 50px;
            }

            .product-card {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(168, 209, 232, 0.1);
                transition: all 0.3s ease;
                cursor: pointer;
            }

            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 40px rgba(168, 209, 232, 0.2);
            }

            .product-image {
                width: 100%;
                height: 300px;
                background: linear-gradient(135deg, #e8f4fd, #b8ddf0);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 4rem;
                color: white;
                position: relative;
                overflow: hidden;
            }

            .product-image::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="20" cy="20" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="80" cy="40" r="1.5" fill="rgba(255,255,255,0.1)"/></svg>');
            }

            .product-info {
                padding: 20px;
            }

            .product-name {
                font-size: 1.1rem;
                font-weight: 600;
                color: #374151;
                margin-bottom: 8px;
            }

            .product-category {
                font-size: 0.9rem;
                color: #6b7280;
                margin-bottom: 12px;
            }

            .product-price {
                font-size: 1.3rem;
                font-weight: 700;
                color: #5a9bd4;
                margin-bottom: 15px;
            }

            .product-actions {
                display: flex;
                gap: 10px;
            }

            .add-to-cart-btn {
                flex: 1;
                background: linear-gradient(135deg, #5a9bd4, #7db3df);
                color: white;
                border: none;
                padding: 12px 16px;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 0.9rem;
            }

            .add-to-cart-btn:hover {
                background: linear-gradient(135deg, #4a8bc2, #6da3d4);
                transform: translateY(-1px);
            }

            .wishlist-btn {
                background: white;
                border: 2px solid #e5f3ff;
                color: #5a9bd4;
                padding: 12px;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 1rem;
            }

            .wishlist-btn:hover {
                background: #e5f3ff;
                border-color: #a8d1e8;
            }

            /* Loading and Empty States */
            .loading {
                text-align: center;
                padding: 60px 20px;
                color: #6b7280;
            }

            .no-products {
                text-align: center;
                padding: 60px 20px;
                color: #6b7280;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .nav-menu {
                    display: none;
                }

                .hero-section h1 {
                    font-size: 2rem;
                }

                .filter-container {
                    flex-direction: column;
                    align-items: stretch;
                }

                .products-grid {
                    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                    gap: 20px;
                }

                .user-menu {
                    gap: 10px;
                }

                .welcome-text {
                    display: none;
                }
            }

            @media (max-width: 480px) {
                .main-container {
                    padding: 20px 15px;
                }

                .products-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <header class="header">
            <div class="nav-container">
                <a href="home.jsp" class="logo">
                    👗 StyleHub
                </a>

                <nav>
                    <ul class="nav-menu">
                        <li><a href="home.jsp">Home</a></li>
                        <li><a href="products.jsp">All Products</a></li>
                        <li><a href="categories.jsp">Categories</a></li>
                        <li><a href="about.jsp">About</a></li>
                        <li><a href="contact.jsp">Contact</a></li>
                    </ul>
                </nav>

                <div class="user-menu">
                    <span class="welcome-text">Welcome, <span class="username"><%= username %></span></span>

                    <button class="cart-icon" onclick="showCart()">
                        🛒
                        <span class="cart-count" id="cartCount">0</span>
                    </button>

                    <form action="logoutServlet" method="post" style="display: inline;">
                        <button type="submit" class="logout-btn">Logout</button>
                    </form>
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <main class="main-container">
            <!-- Hero Section -->
            <section class="hero-section">
                <h1>Discover Your Perfect Style</h1>
                <p>Browse our latest collection of trendy clothing and accessories. Find the perfect outfit for every occasion.</p>
            </section>

            <!-- Filter Section -->
            <section class="filter-section">
                <div class="filter-container">
                    <div class="filter-group">
                        <label for="categoryFilter">Category</label>
                        <select id="categoryFilter" onchange="filterProducts()">
                            <option value="">All Categories</option>
                            <option value="tops">Tops</option>
                            <option value="bottoms">Bottoms</option>
                            <option value="dresses">Dresses</option>
                            <option value="accessories">Accessories</option>
                            <option value="shoes">Shoes</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label for="priceFilter">Price Range</label>
                        <select id="priceFilter" onchange="filterProducts()">
                            <option value="">All Prices</option>
                            <option value="0-25">$0 - $25</option>
                            <option value="25-50">$25 - $50</option>
                            <option value="50-100">$50 - $100</option>
                            <option value="100+">$100+</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label for="sortFilter">Sort By</label>
                        <select id="sortFilter" onchange="filterProducts()">
                            <option value="newest">Newest First</option>
                            <option value="price-low">Price: Low to High</option>
                            <option value="price-high">Price: High to Low</option>
                            <option value="name">Name A-Z</option>
                        </select>
                    </div>
                </div>
            </section>

            <!-- Products Grid -->
            <section class="products-grid" id="productsGrid">
                <!-- Products will be loaded here by JavaScript -->
            </section>
        </main>

        <script>
            // Sample product data - In real application, this would come from your database
            const sampleProducts = [
                {
                    id: 1,
                    name: "Elegant Summer Dress",
                    category: "dresses",
                    price: 45.99,
                    emoji: "👗",
                    description: "Beautiful floral summer dress perfect for any occasion"
                },
                {
                    id: 2,
                    name: "Classic White Shirt",
                    category: "tops",
                    price: 29.99,
                    emoji: "👔",
                    description: "Timeless white shirt for professional and casual wear"
                },
                {
                    id: 3,
                    name: "Denim Jeans",
                    category: "bottoms",
                    price: 59.99,
                    emoji: "👖",
                    description: "Comfortable high-quality denim jeans"
                },
                {
                    id: 4,
                    name: "Stylish Handbag",
                    category: "accessories",
                    price: 89.99,
                    emoji: "👜",
                    description: "Elegant handbag for everyday use"
                },
                {
                    id: 5,
                    name: "Running Sneakers",
                    category: "shoes",
                    price: 79.99,
                    emoji: "👟",
                    description: "Comfortable sneakers for sports and casual wear"
                },
                {
                    id: 6,
                    name: "Cozy Sweater",
                    category: "tops",
                    price: 39.99,
                    emoji: "🧥",
                    description: "Warm and comfortable sweater for cold days"
                },
                {
                    id: 7,
                    name: "Formal Blazer",
                    category: "tops",
                    price: 129.99,
                    emoji: "🧥",
                    description: "Professional blazer perfect for business meetings"
                },
                {
                    id: 8,
                    name: "Summer Shorts",
                    category: "bottoms",
                    price: 24.99,
                    emoji: "🩳",
                    description: "Lightweight shorts for hot summer days"
                }
            ];

            let cartItems = [];
            let displayedProducts = [...sampleProducts];

            // Load products on page load
            document.addEventListener('DOMContentLoaded', function () {
                displayProducts(displayedProducts);
                updateCartCount();
            });

            function displayProducts(products) {
                const grid = document.getElementById('productsGrid');

                if (products.length === 0) {
                    grid.innerHTML = '<div class="no-products">No products found matching your criteria.</div>';
                    return;
                }

                grid.innerHTML = products.map(product => `
                    <div class="product-card" onclick="viewProduct(${product.id})">
                        <div class="product-image">
            ${product.emoji}
                        </div>
                        <div class="product-info">
                            <h3 class="product-name">${product.name}</h3>
                            <p class="product-category">${product.category.charAt(0).toUpperCase() + product.category.slice(1)}</p>
                            <div class="product-price">$${product.price.toFixed(2)}</div>
                            <div class="product-actions">
                                <button class="add-to-cart-btn" onclick="addToCart(event, ${product.id})">
                                    Add to Cart
                                </button>
                                <button class="wishlist-btn" onclick="addToWishlist(event, ${product.id})" title="Add to Wishlist">
                                    ♡
                                </button>
                            </div>
                        </div>
                    </div>
                `).join('');
            }

            function filterProducts() {
                const categoryFilter = document.getElementById('categoryFilter').value;
                const priceFilter = document.getElementById('priceFilter').value;
                const sortFilter = document.getElementById('sortFilter').value;

                let filtered = [...sampleProducts];

                // Filter by category
                if (categoryFilter) {
                    filtered = filtered.filter(product => product.category === categoryFilter);
                }

                // Filter by price
                if (priceFilter) {
                    const [min, max] = priceFilter.split('-').map(p => p.replace('+', ''));
                    filtered = filtered.filter(product => {
                        if (max === '')
                            return product.price >= parseFloat(min);
                        return product.price >= parseFloat(min) && product.price <= parseFloat(max);
                    });
                }

                // Sort products
                switch (sortFilter) {
                    case 'price-low':
                        filtered.sort((a, b) => a.price - b.price);
                        break;
                    case 'price-high':
                        filtered.sort((a, b) => b.price - a.price);
                        break;
                    case 'name':
                        filtered.sort((a, b) => a.name.localeCompare(b.name));
                        break;
                    case 'newest':
                    default:
                        // Keep original order (newest first)
                        break;
                }

                displayedProducts = filtered;
                displayProducts(displayedProducts);
            }

            function addToCart(event, productId) {
                event.stopPropagation();

                const product = sampleProducts.find(p => p.id === productId);
                const existingItem = cartItems.find(item => item.id === productId);

                if (existingItem) {
                    existingItem.quantity += 1;
                } else {
                    cartItems.push({...product, quantity: 1});
                }

                updateCartCount();

                // Show feedback
                const button = event.target;
                const originalText = button.textContent;
                button.textContent = 'Added!';
                button.style.background = '#10b981';

                setTimeout(() => {
                    button.textContent = originalText;
                    button.style.background = '';
                }, 1500);
            }

            function addToWishlist(event, productId) {
                event.stopPropagation();

                const button = event.target;
                button.textContent = '♥';
                button.style.color = '#ef4444';

                setTimeout(() => {
                    button.textContent = '♡';
                    button.style.color = '';
                }, 2000);
            }

            function updateCartCount() {
                const totalItems = cartItems.reduce((sum, item) => sum + item.quantity, 0);
                document.getElementById('cartCount').textContent = totalItems;
            }

            function viewProduct(productId) {
                // In a real application, this would navigate to a product detail page
                window.location.href = `product-detail.jsp?id=${productId}`;
            }

            function showCart() {
                // In a real application, this would show a cart modal or navigate to cart page
                if (cartItems.length === 0) {
                    alert('Your cart is empty. Add some products first!');
                } else {
                    const cartSummary = cartItems.map(item =>
                            `${item.name} x${item.quantity} - $${(item.price * item.quantity).toFixed(2)}`
                                        ).join('\n');

                                        const total = cartItems.reduce((sum, item) => sum + (item.price * item.quantity), 0);

                                        alert(`Cart Contents:\n\n${cartSummary}\n\nTotal: $${total.toFixed(2)}\n\n(This would normally open the cart page)`);
                                    }
                                }
        </script>
    </body>
</html>