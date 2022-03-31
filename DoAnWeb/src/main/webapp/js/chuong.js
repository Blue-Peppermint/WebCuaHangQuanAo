// Tài Khoản người dùng 
function User(username, password, idRole, avatarImg, name, phone, email, address) {
    this.username = username
    this.password = password
    this.idRole = idRole
    this.avatarImg = avatarImg
    this.name = name
    this.phone = phone
    this.email = email
    this.address = address
}
var user1 = new User('chuong', '123', 1, 'https://img.freepik.com/free-photo/mand-holding-cup_1258-340.jpg?size=626&ext=jpg', 'Ung Dinh Chuong')
    // List items dùng để test chức năng load thêm items (Test1.html)
function ItemLoad(itemID, itemName, urlImg, itemPrice, discount) {
    this.itemID = itemID
    this.itemName = itemName
    this.urlImg = urlImg
    this.itemPrice = itemPrice
    this.discount = discount
}
var topFeaturedItems = [
    new ItemLoad(1, 'Sp1', 'images/img-pro-01.jpg', 2000, 15),
    new ItemLoad(3, 'Sp3', 'images/img-pro-03.jpg', 500, 0),
    new ItemLoad(5, 'Sp5', 'images/979.jpg', 5000, 0),
    new ItemLoad(2, 'Sp2', 'images/img-pro-02.jpg', 300, 5),
    new ItemLoad(4, 'Sp4', 'images/img-pro-02.jpg', 500, 10),

]
var bestSellerItems = [
    new ItemLoad(6, 'Sp6', 'images/img-pro-01.jpg', 100, 50),
    new ItemLoad(7, 'Sp7', 'images/img-pro-02.jpg', 20, 0),
    new ItemLoad(8, 'Sp8', 'images/img-pro-02.jpg', 55, 5),
    new ItemLoad(9, 'Sp9', 'images/img-pro-03.jpg', 10, 0),
    new ItemLoad(10, 'Sp10', 'images/img-pro-03.jpg', 10, 0),
    new ItemLoad(11, 'Sp11', 'images/img-pro-03.jpg', 10, 0),
]

// Đơn hàng của Khách chứa list order (cart1.html)
// order chỉ cần có idItem + amount + username
function order(item, amount) {
    this.item = item
    this.amount = amount
}

var cart = [
    new order(new ItemLoad(12, 'Sp12', 'images/img-pro-01.jpg', 100, 20), 1),
    new order(new ItemLoad(13, 'Sp13', 'images/img-pro-02.jpg', 60, 0), 1),
    new order(new ItemLoad(14, 'Sp14', 'images/img-pro-03.jpg', 30.5, 0), 1),
]

function getOrderByID(id) {
    for (var order of cart) {
        if (order.item.itemID == id) {
            return order;
        }
    }
}

// Hóa đơn mua hàng của khách (checkout1.html)
// có thêm thông tin đợt mua đấy có discount hay ko để khi kiểm tra đơn hàng còn biết
function bill(username, orders, recipientName, recipientPhone, recipientEmail, recipientAddress, note) {
    this.username = username
    this.orders = orders
    this.recipientName = recipientName
    this.recipientPhone = recipientPhone
    this.recipientEmail = recipientEmail
    this.recipientAddress = recipientAddress
    this.note = note
}

// Chi tiết + Reviews, Rating của 1 sản phẩm (shop-detail1.html)
// bills dùng để tính số lượng sản phẩm đã bán (BONUS)
function ItemDetail(itemID, itemReviews, decription, imgs, bills) {
    this.itemID = itemID
    this.itemReviews = itemReviews
    this.decription = decription
    this.imgs = imgs
    this.bills = bills
}

function ItemReview(itemID, user, scroreRating, dateReview, content) {
    this.itemID = itemID
    this.user = user
    this.scroreRating = scroreRating
    this.dateReview = dateReview
    this.content = content
}

var itemReviews = [
    new ItemReview(1, user1, 4, new Date(2020, 1, 1), 'Hàng xài cũng tốt'),
    new ItemReview(1, user1, 2, new Date(2022, 1, 2), 'Hàng kém chất lượng'),
    new ItemReview(1, user1, 1, new Date(), 'Hàng kém ')
]


if (window.location.href.includes('home/index.htm')) {
    // ******************************************* Test1.html

    // Nut show special items đang đc active
    var btnActivatedSpecialMenu =
        document.querySelector('.products-box .container .row .col-lg-12 .special-menu.text-center .button-group.filter-button-group button.active');

    // List nút show special items
    var btnShowSpecialMenus =
        document.querySelectorAll('.products-box .container .row .col-lg-12 .special-menu.text-center .button-group.filter-button-group button')

    // Thẻ Div nơi show items
    var divSpecial_list = document.querySelector('.special-li')

    // kiem tra co chuyen sang click nut moi ko?
    var isClickedNewBtn = false;

    // Nút Xem Thêm
    var btnLoadMore = document.querySelector('.products-box #loadMoreSpecialItems')
    for (var btn of btnShowSpecialMenus) {
        btn.addEventListener('click', function(e) {
            // Kiểm tra xem có click sang nút khác ko (Để xác định có nên reset load sản phẩm?)
            if (e.target === btnActivatedSpecialMenu) {
                console.log('Vua moi nhan nut nay r ma')
                isClickedNewBtn = false;
            } else {
                console.log('Chuyen sang nut moi')
                isClickedNewBtn = true;
                btnActivatedSpecialMenu = e.target;
                // load sản phẩm tối đa 4 món
                divSpecial_list.innerHTML = ''
                divSpecial_list.innerHTML += `
                <div class="row-Grid "></div>
    `;
                var items;
                if (btnActivatedSpecialMenu.getAttribute('my-data-filter') === 'top-featured') {
                    items = topFeaturedItems;
                } else if (btnActivatedSpecialMenu.getAttribute('my-data-filter') === 'best-seller') {
                    items = bestSellerItems;
                }
                for (var i = 0; i < 4; i++) {

                    //var divRowGrid = divSpecial_list.querySelector('.row-Grid');
                    //console.log(divSpecial_list)
                    addItemToDiv(divSpecial_list.querySelector('.row-Grid'), items[i])
                }
            }
        })
    }

    btnLoadMore.addEventListener('click', function(e) {
        for (var btn of btnShowSpecialMenus) {
            if (btn.classList.contains('active')) {
                loadMoreItems(btn.getAttribute('my-data-filter'))
            }
        }
    })


    function loadMoreItems(btnName) {
        // Cho biết đã load thêm được mấy item r. Nếu đã nhấn button khác thì reset itemIndexNow
        var itemLoaded = 0;

        var divRowGrids = divSpecial_list.querySelectorAll('.row-Grid');
        for (var divRowGrid of divRowGrids) {
            itemLoaded += divRowGrid.querySelectorAll('.col.span_1_of_4').length
        }

        // List sản phẩm đã và sẽ load
        var items;
        switch (btnName) {
            case 'all':
                itemLoaded += 4;
                console.log('Thuc thi action load items btn All')
                break;
            case 'top-featured':
                console.log('Thuc thi action load items btn top-featured')
                items = topFeaturedItems;
                break;
            case 'best-seller':
                console.log('Thuc thi action load items btn best-seller')
                items = bestSellerItems;
                break;
        }

        // Đếm số lượng sản phẩm đã show trên 1 row. Max = 4
        var count = 0;
        for (itemLoaded; itemLoaded < items.length; itemLoaded++) {
            count++;
            if (count > 4) {
                break;
            }
            // Nếu như đã load hết 4 sản phẩm trên 1 row thì tạo row mới
            if (itemLoaded % 4 == 0) {
                divSpecial_list.innerHTML += `
        <div class="row-Grid "></div>
`;
            }

            divRowGrids = divSpecial_list.querySelectorAll('.row-Grid');
            var divLastRowGrid = divRowGrids[divRowGrids.length - 1]
            addItemToDiv(divLastRowGrid, items[itemLoaded])
        }
    }

    // Thêm 1 sản phẩm vào thẻ div.special-li .row-Grid
    function addItemToDiv(div, item) {
        // Đặt ký hiệu cho item đang xử lý với id = adding-item
        div.innerHTML += `
           <a href = "#">
            <div id = "adding-item" class="col span_1_of_4 ">
                <div class="products-single fix">
                    <div class="box-img-hover">                                 
                    
                     </div>
                    <div class="why-text">
                     </div>
                </div>
             </div>
        </a>
            `;
        // get thẻ div vừa mới add
        var divItemAddingNow = document.querySelector('#adding-item');

        // Thêm tag Img
        var divItemAdding1 =
            divItemAddingNow.querySelector('.products-single.fix .box-img-hover')
        divItemAdding1.innerHTML += `
                <img src="${item.urlImg}" class="img-fluid" alt="Image">
                `;
        // Nếu có giảm giá. Tính giá tiền sản phẩm.
        if (item.discount != 0) {
            divItemAdding1 =
                divItemAddingNow.querySelector('.products-single.fix .box-img-hover')
            divItemAdding1.innerHTML += `
                <div class="type-lb">
                    <p class="sale">Sale ${item.discount}%</p>
                </div>
                `;

            var divItemAdding2 =
                divItemAddingNow.querySelector('.products-single.fix .why-text')
            divItemAdding2.innerHTML = `
                <h4>${item.itemName}</h4>
                <h5>$${item.itemPrice *  (100 -item.discount)/ 100}</h5>
                <span>$${item.itemPrice}</span>              
                `;
        } else {
            // divItemAdding1 =
            //     divItemAddingNow.querySelector('.products-single.fix .box-img-hover')
            // divItemAdding1.innerHTML += `
            // <div class="type-lb">
            //     <p class="new">New</p>
            // </div>
            // `;

            var divItemAdding2 =
                divItemAddingNow.querySelector('.products-single.fix .why-text')
            divItemAdding2.innerHTML = `
            <h4>${item.itemName}</h4>
            <h5>$${item.itemPrice}</h5>
            `;
        }
        // xóa id tự thêm lúc đầu
        divItemAddingNow.removeAttribute('id')
    };
} else
if (window.location.href.includes('cart1.html')) {
    // ******************************************* cart1.html
    var spinners = document.querySelectorAll('.cart-box-main .table tbody input[type="number"]')
    for (var spinner of spinners) {
        spinner.onchange = function(e) {
            console.log(`U just change value of :${e.target}`)
            var trElement = e.target.parentElement.parentElement;

            var order = getOrderByID(trElement.id)
            order.amount = Number(e.target.value);

            // Nếu mục đơn giá có discount thì lấy newUnitPrice bằng cách khác
            var newUnitPrice;
            if (order.item.discount != 0) {
                newUnitPrice = order.item.itemPrice * (100 - order.item.discount) / 100;
            } else {
                newUnitPrice = order.item.itemPrice;
            }

            // Update table data Thành Tiền
            var trTotalPriceElement = trElement.querySelector('.total-pr p');
            trTotalPriceElement.innerHTML = newUnitPrice * order.amount + 'đ'

            // Update mục tổng kết đơn hàng
            var totalPriceNoDiscount = calTotalPriceNoDiscount()
            var totalPriceWithDiscount = calToTalPriceWithDiscount()

            var totalOrderPriceNoDiscountElement = document.querySelector('#totalPriceNoDiscount')
            totalOrderPriceNoDiscountElement.innerHTML = totalPriceNoDiscount + 'đ'

            var totalSavingPriceElement = document.querySelector('#totalSavingPrice')
            totalSavingPriceElement.innerHTML = totalPriceNoDiscount - totalPriceWithDiscount + 'đ'

            var totalOrderPriceWithDiscountElement = document.querySelector('#totalPriceWithDiscount')
            totalOrderPriceWithDiscountElement.innerHTML = totalPriceWithDiscount + 'đ'
        }
    }

    function calTotalPriceNoDiscount() {
        var total = 0;
        for (var order of cart) {
            total += order.item.itemPrice * order.amount
        }
        return total
    }

    function calToTalPriceWithDiscount() {
        var total = 0;
        for (var order of cart) {
            if (order.item.discount != 0) {
                var newPrice = order.item.itemPrice * (100 - order.item.discount) / 100;
                total += newPrice * order.amount
            } else {
                total += order.item.itemPrice * order.amount
            }
        }
        return total
    }
} else if (window.location.href.includes('shop-detail1.html')) {
    // hiển thị tổng số lượng rating. Phần này xử lý bên view
    // showTotalRating()

    // hiển thị tổng sao rating sản phẩm
    showTotalStarRating()

    showStarRatingForAll();

    // Nút xem tất cả review. Sắp xếp từ mới -> cũ
    var btnLoadMore = document.querySelector('#btnLoadMore')
    btnLoadMore.onclick = function(e) {
        itemReviews.sort(function(a, b) {
            return b.dateReview - a.dateReview;
        })
        var length = itemReviews.length
        for (var i = 0; i < length; i++) {
            if (i == length - 1) {
                addingReview(itemReviews[i], false)
            } else {
                addingReview(itemReviews[i], true)
            }

        }
    };
    // Thêm 1 review vào 
    function addingReview(review, isFinalReview) {
        var divReviews = document.querySelector('.restaurant-detailed-ratings-and-reviews')
        btnLoadMore.remove()
        divReviews.innerHTML += `
            <div class="reviews-members pt-4 pb-4">
            <div class="media">
                <!-- Hint: Avatar cá nhân -->
                <a href="#"><img alt="Avatar User" src="" class="mr-3 rounded-pill"></a>
                <div class="media-body">
                    <div class="reviews-members-header">
                        <!-- Hint: Đánh giá Sao của cá nhân -->
                        <div class="star-rating float-right">
                            <a href="#"><i class="fas fa-star "></i></a>
                            <a href="#"><i class="fas fa-star "></i></a>
                            <a href="#"><i class="fas fa-star "></i></a>
                            <a href="#"><i class="fas fa-star "></i></a>
                            <a href="#"><i class="fas fa-star "></i></a>
                        </div>
                        <!-- Hint: Tên Khách review + Ngày review -->
                        <h6 class="mb-1"><a class="text-black" href="#">Singh Osahan</a></h6>
                        <p class="text-gray">Tue, 20 Mar 2020</p>
                    </div>
                    <!-- Hint: Nội dung review -->
                    <div class="reviews-members-body">
                        <p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin
                            professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical
                            literature, discovered the undoubtable source. Lorem Ipsum comes from sections </p>
                    </div>
                    <div class="reviews-members-footer">
                        <a class="my-total-like" href="#"><i class="fad fa-thumbs-up"></i></a> <a class="my-total-like" href="#"><i class="fad fa-thumbs-down"></i> </a>
                    </div>
                </div>
            </div>
        </div>

    `;
        var divReviewProcessing = divReviews.lastElementChild;
        // Thêm avatar, star rating, date review, content review
        divReviewProcessing.querySelector('.mr-3.rounded-pill').src = `${review.user.avatarImg}`
        var divStarRating = divReviewProcessing.querySelector('.star-rating.float-right').children
        for (var i = 0; i < divStarRating.length && i < review.scroreRating; i++) {
            divStarRating[i].querySelector('i').classList.add('active')
        }

        divReviewProcessing.querySelector('.text-black').innerText = review.user.name

        var dd = String(review.dateReview.getDate()).padStart(2, '0');
        var mm = String(review.dateReview.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = review.dateReview.getFullYear();

        var hh = String(review.dateReview.getHours())
        var mm2 = String(review.dateReview.getMinutes())
        var ss = String(review.dateReview.getSeconds())
        var timeFormatted = `${mm}/${dd}/${yyyy} ${hh}:${mm2}`;
        divReviewProcessing.querySelector('.text-gray').innerText = timeFormatted

        divReviewProcessing.querySelector('.reviews-members-body p').innerText = review.content

        if (isFinalReview) {
            divReviews.innerHTML += '<hr>'
        }
    }

    // show tổng rating sản phẩm
    function showTotalStarRating() {
        var totalRating = itemReviews.reduce(function(returnVal, val) {
            return returnVal + val.scroreRating;
        }, 0)


        const starRatingWrapperArr = document.querySelectorAll('.percentage-star-rating');
        const frontStarsArr = document.querySelectorAll('.front-stars');

        var percentage = ((totalRating / (5 * itemReviews.length)) * 100) + '%'

        for (var starRating of starRatingWrapperArr) {
            starRating.title = percentage;
        }
        for (var frontStars of frontStarsArr) {
            frontStars.style.width = percentage;
        }

    }

    // show tổng rating của tất cả loại sao (trong phần đánh giá)
    function showStarRatingForAll() {

        var starRatingLvl1 = itemReviews.reduce(function(returnVal, val) {
            if (val.scroreRating == 1) {
                return returnVal += 1
            }
            return returnVal
        }, 0)
        var starRatingLvl2 = itemReviews.reduce(function(returnVal, val) {
            if (val.scroreRating == 2) {
                return returnVal += 1
            }
            return returnVal
        }, 0)
        var starRatingLvl3 = itemReviews.reduce(function(returnVal, val) {
            if (val.scroreRating == 3) {
                return returnVal += 1
            }
            return returnVal
        }, 0)
        var starRatingLvl4 = itemReviews.reduce(function(returnVal, val) {
            if (val.scroreRating == 4) {
                return returnVal += 1
            }
            return returnVal
        }, 0)
        var starRatingLvl5 = itemReviews.reduce(function(returnVal, val) {
            if (val.scroreRating == 5) {
                return returnVal += 1
            }
            return returnVal
        }, 0)

        var percentageOfRatingLv1 = ((starRatingLvl1 / itemReviews.length) * 100 + '%')
        var percentageOfRatingLv2 = ((starRatingLvl2 / itemReviews.length) * 100 + '%')
        var percentageOfRatingLv3 = ((starRatingLvl3 / itemReviews.length) * 100 + '%')
        var percentageOfRatingLv4 = ((starRatingLvl4 / itemReviews.length) * 100 + '%')
        var percentageOfRatingLv5 = ((starRatingLvl5 / itemReviews.length) * 100 + '%')

        showStarRatingForEach(1, starRatingLvl1, percentageOfRatingLv1)
        showStarRatingForEach(2, starRatingLvl2, percentageOfRatingLv2)
        showStarRatingForEach(3, starRatingLvl3, percentageOfRatingLv3)
        showStarRatingForEach(4, starRatingLvl4, percentageOfRatingLv4)
        showStarRatingForEach(5, starRatingLvl5, percentageOfRatingLv5)
    }

    // show tổng rating của 1 loại sao (sao 1, sao 2,...) (trong phần đánh giá)
    function showStarRatingForEach(level, total, percentageOfTotal) {
        var divGraphRatingBody = document.querySelector('.graph-star-rating-body')
        var ratingListNow = divGraphRatingBody.lastElementChild;

        var lvlNow = 1;
        while (lvlNow < level) {
            ratingListNow = ratingListNow.previousElementSibling
            lvlNow++;
        }
        ratingListNow.querySelector('.progress-bar').style.width = percentageOfTotal
        ratingListNow.querySelector('.rating-list-right').innerHTML = total
    }

    // func ko sử dụng
    function showTotalRating() {
        var totalRating = itemReviews.length + ' đánh giá'
        var productDetailElement = document.querySelector('.single-product-details')
        productDetailElement.querySelector('.star-rating.text-black.ml-2').innerHTML = totalRating

        var divGraphRatingHeader = document.querySelector('.graph-star-rating-header')
        divGraphRatingHeader.querySelector('.star-rating.text-black.ml-2').innerHTML = totalRating
    }
} else if (window.location.href.includes('shop1.html')) {
    // Sắp xếp sản phẩm (theo mặc định (a-z), mua nhiều, giá thấp-> cao, giá cao -> thấp, bonus mới nhất)
    var items = topFeaturedItems;
    items.sort((a, b) => {
        return ('' + a.itemName).localeCompare(b.itemName);
    })
    loadProductsGridView(items)

    var toolBarEle = document.querySelector('.toolbar-sorter-right select')
    toolBarEle.addEventListener('change', function(e) {
        var selectedSortByVal = toolBarEle.options[toolBarEle.selectedIndex].value
        switch (selectedSortByVal) {
            // Sắp xếp mặc định (a-z)
            case '0':
                items.sort((a, b) => {
                    return ('' + a.itemName).localeCompare(b.itemName);
                })
                break;
                // Sắp xếp theo giá từ thấp -> cao 
            case '1':
                items.sort((a, b) => {
                    var priceA = a.itemPrice;
                    var priceB = b.itemPrice;
                    if (a.discount != 0) {
                        priceA = a.itemPrice * (100 - a.discount) / 100
                    }
                    if (b.discount != 0) {
                        priceB = b.itemPrice * (100 - b.discount) / 100
                    }
                    return priceA - priceB
                })
                break;
                // Sắp xếp theo giá từ cao -> thấp 
            case '2':
                items.sort((a, b) => {
                    var priceA = a.itemPrice;
                    var priceB = b.itemPrice;
                    if (a.discount != 0) {
                        priceA = a.itemPrice * (100 - a.discount) / 100
                    }
                    if (b.discount != 0) {
                        priceB = b.itemPrice * (100 - b.discount) / 100
                    }
                    return priceB - priceA
                })
                break;
                // Sắp xếp mua nhiều
            case '3':

                break;
            case '4':
                break;
        }
        loadProductsGridView(items)
    })

    // Thanh tìm kiếm theo tên sản phẩm
    var searchProductBar = document.querySelector('.search-product')
    var inputSearchProduct = searchProductBar.querySelector('input')
    var btnSearchProduct = searchProductBar.querySelector('button')
    btnSearchProduct.addEventListener('click', function(e) {
        var itemShow = [];
        var searchVal = inputSearchProduct.value.trim()
        for (var product of items) {
            if (product.itemName.includes(searchVal)) {
                itemShow.push(product)
            }
        }
        loadProductsGridView(itemShow)
    })

    // Filter theo giá tiền tự chọn
    var maxPrice = items.reduce(function(returnVal, val) {
        var priceNow = val.itemPrice;
        if (val.discount != 0) {
            priceNow = val.itemPrice * (100 - val.discount) / 100
        }
        if (returnVal > priceNow) {
            return returnVal
        }
        return priceNow;
    }, 0)

    var fromPrice = 0;
    var toPrice = 0;
    var leftPriceSlider = document.querySelectorAll('#slider-range span')[0]
    var rightPriceSlider = document.querySelectorAll('#slider-range span')[1]

    var observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutationRecord) {
            var leftWitdhStr = mutationRecord.target.style.left.trim()
            leftWitdhStr = leftWitdhStr.slice(0, leftWitdhStr.length - 1)
            var priceChanged = Number(leftWitdhStr) * maxPrice / 100
            if (mutationRecord.target == leftPriceSlider) {
                fromPrice = priceChanged
            } else {
                toPrice = priceChanged
            }
            showPriceFilterVal(fromPrice, toPrice)
        });
    });

    observer.observe(leftPriceSlider, { attributes: true, attributeFilter: ['style'] });
    observer.observe(rightPriceSlider, { attributes: true, attributeFilter: ['style'] });

    var btnFilterPrice = document.querySelector('.price-box-slider button')
    btnFilterPrice.onclick = function(e) {
        var itemShow = [];
        for (var product of items) {
            var price = product.itemPrice;
            if (product.discount != 0) {
                price = product.itemPrice * (100 - product.discount) / 100
            }
            if ((price >= fromPrice && price < toPrice) || (price > fromPrice && price <= toPrice)) {
                itemShow.push(product)
            }
        }
        loadProductsGridView(itemShow)
    }

    // Load sản phẩm khi scroll mouse hoặc click bootstrap Pagination

    // Hiển thị số lượng kết quả tìm thấy 

    function loadProductsGridView(products) {
        var amountProductShow = 0;
        var productContainer = document.querySelector('#grid-view .row')
        productContainer.innerHTML = ''
        for (var product of products) {
            loadProductGridView(product)
            amountProductShow++
        }
        showNumberResultFound(amountProductShow)
    }

    function loadProductGridView(product) {
        var productContainer = document.querySelector('#grid-view .row')
        productContainer.innerHTML += `
                <div class="col-sm-6 col-md-6 col-lg-4 col-xl-3">
                <div class="products-single fix">
                    <a href="">
                        
                    </a>

                </div>
            </div>
        `;
        var divProductProcessing = productContainer.lastElementChild
        if (product.discount != 0) {
            divProductProcessing.querySelector('a').innerHTML += `
            <div class="box-img-hover">
                            <div class="type-lb">
                                <p class="sale">Sale ${product.discount}%</p>
                            </div>
                            <img src="${product.urlImg}" class="img-fluid" alt="Image">
            </div>
            <div class="why-text">
                <a href="">
                    <h4>${product.itemName}</h4>
                </a>
                <h5>${product.itemPrice *  (100 -product.discount)/ 100}</h5>
                <span>${product.itemPrice}</span>    
            </div>
        `
        } else {
            divProductProcessing.querySelector('a').innerHTML += `
            <div class="box-img-hover">
                            <img src="${product.urlImg}" class="img-fluid" alt="Image">
            </div>
            <div class="why-text">
                <a href="">
                    <h4>${product.itemName}</h4>
                </a>
                <h5>${product.itemPrice}</h5>
            </div>
        `
        }
    }

    function showNumberResultFound(itemFound) {
        var showResultEle = document.querySelector('.product-item-filter p')
        showResultEle.innerText = `${itemFound} sản phẩm tìm thấy`
    }

    function showPriceFilterVal(fromPrice, toPrice) {
        var priceFilterValEl = document.querySelector('#priceFilterVal')
        var valStr = fromPrice.toFixed(0) + ' - ' + toPrice.toFixed(0)
        priceFilterValEl.value = valStr
    }
}