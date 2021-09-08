import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHelper extends ChangeNotifier {
  int idx;
  bool showMoreText = false;
  int detailsScreenListPickedItem = 1;
  String searchWord = '';
  List myFilterdArray;
  String searchSectionintilValue = '';
  List comments;
  String userKey;
  int homePageFooterNum = 1;

  Map newUser;

  List places = [
    {
      'name': 'Jackson Hole',
      'image': 'Jackson_Hole.jpg',
      'price': '900',
      'place': 'Wyoming',
      'details':
          'summer vacation. In a pre-Covid world, those words would have conjured up grand plans: rollicking around the French Riviera, digging into fresh uni at Lo Scoglio on the Amalfi Coast, kayaking on the turquoise lakes of Banff National Park in Canada, basking in 24 hours of daylight in Iceland. One year into the pandemic, a lot is still uncertain, especially in regards to where we will be able to travel—and, more importantly, when. But President Biden has promised that all Americans will be eligible for vaccinations by May 1, instilling a sense of hope and optimism that, among other things, summer vacation 2021 might be possible after all.'
    },
    {
      'name': 'Montecito',
      'image': 'Montecito.jpg',
      'price': '500',
      'place': 'California',
      'details':
          'Jackson Hole is a year-round playground for the rich and adventurous, but come summer, the list of things to do expands exponentially. Proximity to two national parks—Grand Teton and Yellowstone—means plenty of warm weather activities like hiking, paddle-boarding, kayaking, whitewater rafting, horseback riding, wildlife tours, biking, fishing, camping, you get the idea. Plus, the spectacular mountain scenery and perfect summer temperatures really can\'t be beat. Stay at the Amangani, whose in-house naturalists will lead private tours through the national parks.'
    },
    {
      'name': 'Mykonos',
      'image': 'Mykonos.jpg',
      'price': '800',
      'place': 'Greece',
      'details':
          'Maybe leave the kids at home for this one. Arguably the most romantic hotel on the west coast, the 129-year-old San Ysidro Ranch has quite a storied history—Vivien Leigh and Laurence Olivier were married here, while Jackie and John F. Kennedy honeymooned at the resort. Just 41 standalone cottages—decorated with antiques and appointed with stone fireplaces, outdoor rain showers, deep soaking tubs, and private decks—are sprawled out over 500 acres of lush gardens and hiking trails lined with lavender, jasmine, orange blossoms, and eucalyptus. Plus, due to the pandemic, meals are now included in the nightly rate, with no exceptions (meaning you can get the caviar, bone-in steak, and lobster cioppino, all at no extra cost).'
    },
    {
      'name': 'San Miguel de Allende',
      'image': 'San_Miguel_de_Allende.jpg',
      'price': '1200',
      'place': 'Mexico',
      'details':
          'Yes, you read that right. For certain U.S. citizens—namely those who can produce an antibodies test, a negative PCR result, or proof of a vaccination—Greece can very much be a possibility this summer. The country announced that it plans to open to all travelers on May 14. There are so many places to visit, from the ancient wonders of Athens to the many islands dotting the Aegean and Ionian Seas—the latest hotspot to join the party will be the Kalesma Mykonos, which opens in May. A sleek design aesthetic—and high fashion cred—will differentiate this 25-suite hotel (plus two villas) from its peers. Think Rick Owens furniture in the lobby, custom artwork in each room, horsehair sconces in a nod to the Greek god Apollo, who was said to have kept his horses in the area. Oh, and best of all, 360-degree views.'
    },
    {
      'name': 'Watch Hill',
      'image': 'Watch_Hill.jpg',
      'price': '650',
      'place': 'Rhode Island',
      'details':
          'With pleasant spring-like temperatures pretty much all year long, there really is no bad time to visit this charming, historic town. While summer is technically its rainy season, here\'s the silver lining: arid hills bloom into a rainbow panoply of wildflowers. Make the Rosewood San Miguel de Allende home base from which to explore the colorful UNESCO World Heritage Site. The hotel\'s 67 rooms and suites are a study in hacienda chic, with wood-beam ceilings, hand-carved artisan furniture, spacious terraces, and a palette of warm tones. With six restaurants, clay tennis courts, a spa, and activities from movie nights to lavender workshops, you\'ll find plenty to do.'
    },
    {
      'name': 'Ojai',
      'image': 'Ojai.jpg',
      'price': '430',
      'place': 'California',
      'details':
          'Ojai is famous for its New Age, woo woo vibes, but after the year we\'ve had, a whopping dose of positive energy—delivered via its seven spiritual vortexes—could not be more welcome. The Ojai Valley Inn is fresh off a months-long renovation project at its renowned, award-winning Spa Ojai. All of the oasis\'s treatment rooms, public spaces, and even the two 1,500-square-foot penthouse suites have been given a complete upgrade. There are many opportunities to continue the wellness journey elsewhere on the hotel\'s 200-acre property. The vast activities and classes list includes aromatherapy oil blending, beekeeping, spiritual counseling, crystal healing, and floral design. Or you could just laze about in one of the hotel\'s four pools all afternoon, then enjoy an alfresco dinner while admiring Ojai\'s iconic pink sunsets.'
    },
    {
      'name': 'Montego Bay',
      'image': 'Montego_Bay.jpg',
      'price': '1800',
      'place': 'Jamaica',
      'details':
          'Sure, the Caribbean might be really hot this time of year, but does that really matter when you\'ve got pools, beaches, bottomless rum cocktails, a languorous island pace, and fewer crowds? With 27 villas plus 36 rooms designed by Ralph Lauren, Round Hill makes for a chic getaway. You could also stay the whole season, courtesy of the hotel\'s "Home Away From Home" package, which includes enhanced tech support for the WFH crowd, daily babysitting services, and specially curated menus for better productivity. Plus, nothing really beats ending the workday with a sunset swim, leisurely kayak, or a luxurious massage.'
    }
  ];
  final Map user = {
    'name': 'majd',
    'email': 'majd@gmail.com',
    'places': {
      'Jackson Hole': {'book': false, 'like': false},
      'Montecito': {'book': false, 'like': false},
      'Mykonos': {'book': false, 'like': false},
      'San Miguel de Allende': {'book': false, 'like': false},
      'Watch Hill': {'book': false, 'like': false},
      'Montego Bay': {'book': false, 'like': false},
      'Ojai': {'book': false, 'like': false},
    }
  };

  getByIndex(int idx) {
    return places[idx];
  }

  void setIdx(int index) {
    idx = index;
  }

  void showMore() {
    showMoreText = true;
    notifyListeners();
  }

  void showLess() {
    showMoreText = false;
    notifyListeners();
  }

  void setIndetailsScreenListPickedItem(int num) {
    detailsScreenListPickedItem = num;
    notifyListeners();
  }

  void setSearchWord(String word) {
    searchWord = word;
    notifyListeners();
  }

  void filterdArray() {
    myFilterdArray = (searchWord == null)
        ? places
        : places
            .where(
              (element) => element['name'].toLowerCase().contains(
                    searchWord.toLowerCase(),
                  ),
            )
            .toList();
  }

  void addEmailAndUserName(var currentUser) {
    newUser = currentUser;
  }

  void setInHomeScreenListPickedItem(int num) {
    homePageFooterNum = num;
    notifyListeners();
  }

  void setUserID(String userId) {
    userKey = userId;
  }
}
