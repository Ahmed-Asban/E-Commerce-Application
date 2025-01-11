<?php
// الاتصال بقاعدة البيانات
include './connect.php'; // تأكد من أنك تتصل بقاعدة البيانات بشكل صحيح

// استعلام لاسترجاع المنتجات في السلة بناءً على product_id
$sql = "SELECT c.id, c.quantity, p.title, p.price, p.image_path
        FROM cart c
        JOIN productss p ON c.product_id = p.id"; // جلب المنتجات من السلة باستخدام product_id

// تنفيذ الاستعلام
$result = mysqli_query($con, $sql);

// التحقق من وجود بيانات في السلة
$cart_items = []; // مصفوفة لتخزين المنتجات

if (mysqli_num_rows($result) > 0) {
    // استعراض المنتجات المضافة إلى السلة
    while ($row = mysqli_fetch_assoc($result)) {
        // إضافة البيانات إلى المصفوفة
        $cart_items[] = [
            'id' => $row['id'],
            'title' => $row['title'],
            'price' => $row['price'],
            'quantity' => $row['quantity'],
            'image_path' => $row['image_path'],
            'total_price' => $row['price'] * $row['quantity']
        ];
    }

    // إرسال البيانات في صيغة JSON
    echo json_encode($cart_items);
} else {
    // إذا كانت السلة فارغة
    echo json_encode([]);
}
?>