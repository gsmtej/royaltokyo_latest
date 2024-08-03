import 'package:buyer_app/models/LoginModel.dart';

User? userInfo;

class AppConfig {
  static String BASEURL = 'https://royaltokyosushi.be/api/';
  static String LOGIN = '${BASEURL}login';
  static String REGISTER = '${BASEURL}register';
  static String GET_HOMEPAGE_DETAIL = '${BASEURL}details/get-homepage-details';
  static String GET_PRODUCT_CATEGORIES = '${BASEURL}product/restaurantpage/';
  static String GET_DISHES_RESTAURANT =
      '${BASEURL}get-restaurant-by-dishes-id/';
  static String ADD_TO_CART = '${BASEURL}restaurant/cart/add-to-cart/';
  static String GET_CART = '${BASEURL}restaurant/cart/get-cart';
  static String INCREMENT_CART = '${BASEURL}restaurant/cart/cart-increment/';
  static String DECREMENT_CART = '${BASEURL}restaurant/cart/cart-decrement/';
  static String REMOVE_CART = '${BASEURL}restaurant/cart/remove-cart/';
  static String PRODUCT_VIEW_MODEL = '${BASEURL}product/view/modal/';
  static String GET_ADDRESS_DETAILS = '${BASEURL}checkout/get-address-details';
  static String ADD_NEW_ADDRESS = '${BASEURL}checkout/add-new-address';
  static String CHANGE_DELIVERY_ADDRESS =
      '${BASEURL}checkout/change-delivery-address';
  static String GET_TIME_SLOT = '${BASEURL}details/restaurant/get-time-slot';
  static String CHANGE_ORDER_TYPE = '${BASEURL}details/change-order-type';
  static String COD_PAYMENT = '${BASEURL}checkout/order/cod-payment';
  static String MOLLIE_PAYMENT = '${BASEURL}checkout/order/mollie-payment';
  static String APPLY_CART_COUPON = '${BASEURL}checkout/apply-cart-coupon';
  static String APPLY_CART_GIFT_COUPON = '${BASEURL}checkout/apply-gift-card';
  static String CALCULATE_DISCOUNT = '${BASEURL}restaurant/calculate-discount';
  static String MY_ORDERS = '${BASEURL}user/orders';
  static String GET_MY_PROFILE = '${BASEURL}user/profile';
  static String UPDATE_MY_PROFILE = '${BASEURL}user/update-profile';
  static String GET_RESTAURANT_BY_CATEGORY =
      '${BASEURL}get-restaurants-by-food-category';
  // static String GET_RESTAURANT_BY_CATEGORY = '${BASEURL}get-restaurants-by-category';

  //Gift Cards
  static String GET_RESTAURANT_GIFT_CARDS =
      '${BASEURL}resturant-gift-card/get/';
  static String GET_USER_GIFT_CARDS = '${BASEURL}user-gift-card/get';
  static String USER_TRANSFER_GIFT_CARDS = '${BASEURL}user-transfer-gift-card';
  static String PURCHASE_GIFT_CARDS = '${BASEURL}purchase-gift-card';
}
