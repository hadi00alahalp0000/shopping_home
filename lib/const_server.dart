class ConstServer {
  /// ************************************************************************************************************************************/

  // Domain Name
  static const domaiNname = 'http://192.168.43.10:8000';

  /// ************************************************************************************************************************************/

  // Auth
  static const register = '/api/register';
  static const signIn = '/api/login';
  static const signOut = '/api/logout';
  static const sendOtb = '/api/email/sendbasicemail';
  static const sendForgetPasswordOtb = '/api/email/sendotbforgetpassword';
  static const checkToken = '/api/check_validation';
  static const refreshToken = '/api/refreshtoken';
  static const forgetPassword = '/api/forgetpassword';

  /// ************************************************************************************************************************************/

  // Home
  static const search = "/api/Search?key=";
  static const products = "/api/products/";

  /// ************************************************************************************************************************************/

  // Show Products
  static const showAllProducts = '/api/ShowAllProducts';
  static const showAllProductsByCategoryId = '/api/ShowAllProductCategory?id=';
  static const showAllProductsByUser = '/api/ShowAllProductByUser?user_id=';
  static const showAllSortedProducts = '/api/Sort?sort=';
  static const showAllMyProducts = '/api/ShowAllMyProduct';
  static const showAllProductsHaveMyLike = '/api/ShowAllProductMyLike';
  static const showAllProductsHaveMyView = '/api/ShowAllProductMyView';
  static const showAllProductsHaveMyReview = '/api/ShowAllProductMyReview';

  /// ************************************************************************************************************************************/

  // Profile
  static const myProfile = "/api/get_me";
  static const updateMyProfile = "/api/update_me";
  static const sendimageprofile = "/api/image/user";

  /// ************************************************************************************************************************************/

  // Products
  static const comments = '/api/comment/allcomment/';
  static const sendcomment = '/api/comment/';
  //static const imageProduct = '/api/image/product';
  static const addProduct = '/api/AddMyProduct';
  static const editProduct = '/api/UpdateMyProduct?product_id=';
  static const deleteProduct = '/api/DeleteMyProduct?product_id=';

  /// ************************************************************************************************************************************/

  // Image
  static const userImage = '/api/image/user';
  static const productImage = '/api/image/product';
  static const checkUserImage = '/api/image/check';

  /// ************************************************************************************************************************************/

  //Category
  static const showAllCategories = '/api/ShowAllCategory';

  /// ************************************************************************************************************************************/

  // Show Users
  static const showUserById = '/api/show_user?id=';
  static const showUserByProductId = '/api/show_user?id=';
  static const showAllUsersLikedProduct = '/api/ShowAllUserByLikeInProduct?id=';
  static const showAllUsersSawProduct = '/api/ShowAllUserByViewInProduct?id=';
  static const showAllUsersReviewedProduct =
      '/api/ShowAllUserByViewInProduct?id=';

  /// ************************************************************************************************************************************/

  // Like
  static const addLike = '/api/AddLike?id=';
  static const deleteLike = '/api/DeleteLike?id=';
  static const checkLike = '/api/CheckIsLike?id=';

  /// ************************************************************************************************************************************/

  // View
  static const addView = '/api/AddView?id=';

  /// ************************************************************************************************************************************/
  // ReView
  static const addReview = '/api/AddReview?id=';
  static const updateReview = '/api/UpdateMyReview?id=';
  static const deleteReview = '/api/DeleteMyReview?id=';
  static const showAllReview = '/api/ShowAllReviewInProduct?id=';

  /// ************************************************************************************************************************************/

  // Wallet
  static const showMyWallet = '/api/ShowMyWallet';
  static const showUserWallet = '/api/ShowWallet?wallet_id=';
  //static const addBalanceWallet = '/api/AddBalanceWallet?wallet_id=' + '$wallet_id' +'&user_id=' + '$user_id';
  //static const deleteBalanceWallet = '/api/DeleteBalanceWallet?wallet_id=' + '$wallet_id' +'&user_id=' + '$user_id';

  /// ************************************************************************************************************************************/

  // Order
  static const addProductToMyOrder = '/api/AddProductToMyOrder?product_id=';
  static const deleteProductFromMyOrder =
      '/api/DeleteProductFromMyOrder?product_id=';
  static const deleteAllProductsFromMyOrder =
      '/api/DeleteAllProductsFromMyOrder';
  static const editProductInMyOrder = '/api/updateQuantity?product_id=';
  static const buyMyOrder = '/api/BuyMyOrder';
  static const showMyOrder = '/api/ShowProductInMyOrder';

  /// ************************************************************************************************************************************/

  // Record
  static const payRecord = '/api/ShowAllMyPayRecord';
  static const giveRecord = '/api/ShowAllMyGiveRecord';
  static const takeRecord = '/api/ShowAllMyTakeRecord';
  static const payRecordDetails = '/api/ShowAllAddByPay?pay_id=';
/**************************************************************************************************************************************/
  static const storeNotification = '/api/storetoken';
  static const showAllMyNotification = '/api/ShowAllMyNotification';
  static const deleteMyNotification = '/api/DeleteMyNotification?id=';
  static const deleteAllMyNotification = '/api/DeleteAllMyNotifications';
}
