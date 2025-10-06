class RequestManager {
  // Singleton pattern
  static final RequestManager _instance = RequestManager._internal();
  factory RequestManager() => _instance;
  RequestManager._internal();

  // Static list to persist requests across navigation
  static List<Map<String, dynamic>> requests = [
    {
      'user': 'lilmitzzz',
      'avatar': 'assets/images/lilmitz.jpg',
      'time': '2h ago',
      'description': 'Looking for someone to paint a christ theme on my denim jacket. Budget: ฿2,500',
      'image': 'assets/images/denim-jacket.jpg',
      'budget': '฿2,500',
      'deadline': '2 weeks',
      'offers': 8,
      'category': 'Jacket',
      'isOwn': false,
    },
    {
      'user': 'styleking',
      'avatar': 'assets/images/styleking.jpg',
      'time': '5h ago',
      'description': 'Need custom embroidery on white hoodie. Minimalist design preferred. Budget: ฿1,800',
      'image': 'assets/images/white-hoodie.jpg',
      'budget': '฿1,800',
      'deadline': '1 week',
      'offers': 12,
      'category': 'Hoodie',
      'isOwn': false,
    },
    {
      'user': 'fashionista_bkk',
      'avatar': 'assets/images/bkkmodel.jpg',
      'time': '1d ago',
      'description': 'Want to customize my jeans with hand-painted flowers. Open to creative ideas!',
      'image': 'assets/images/jeans.jpg',
      'budget': '฿3,000',
      'deadline': '3 weeks',
      'offers': 15,
      'category': 'Jeans',
      'isOwn': false,
    },
  ];

  List<Map<String, dynamic>> getRequests() => requests;

  void addRequest(Map<String, dynamic> request) {
    requests.insert(0, request);
  }

  void removeRequest(int index) {
    if (index >= 0 && index < requests.length) {
      requests.removeAt(index);
    }
  }

  void updateRequest(int index, Map<String, dynamic> updatedRequest) {
    if (index >= 0 && index < requests.length) {
      requests[index] = updatedRequest;
    }
  }
}