import 'package:project_detect_disease_datn/model/post_model_2.dart';
import 'package:project_detect_disease_datn/model/use.dart';

final User currentUser = User(
  name: 'Hoàng Văn',
  imageUrl:
      'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
);

final List<User> onlineUsers = [
  User(
    name: 'David Brooks',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
    name: 'Jane Doe',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
    name: 'Matthew Hinkle',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
    name: 'Amy Smith',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
    name: 'Ed Morris',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
    name: 'Carolyn Duncan',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
    name: 'Paul Pinnock',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
      name: 'Elizabeth Wong',
      imageUrl:
          'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6'),
  User(
    name: 'James Lathrop',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
    name: 'Jessie Samson',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
    name: 'David Brooks',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
    name: 'Jane Doe',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
    name: 'Matthew Hinkle',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
    name: 'Amy Smith',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
    name: 'Ed Morris',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
    name: 'Carolyn Duncan',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
    name: 'Paul Pinnock',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
      name: 'Elizabeth Wong',
      imageUrl:
          'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6'),
  User(
    name: 'James Lathrop',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
  User(
    name: 'Jessie Samson',
    imageUrl:
        'https://scontent.fdad3-5.fna.fbcdn.net/v/t1.6435-9/114181013_1208852119460454_6801772528895704517_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=rwZ85G5mj90AX98LBJi&_nc_ht=scontent.fdad3-5.fna&oh=49e86516b08e355806009cfb3f27993e&oe=61B5D9E6',
  ),
];

final List<Post> posts = [
  Post(
    user: currentUser,
    caption: 'Check out these cool puppers',
    timeAgo: '58m',
    imageUrl:
        'https://baoquocte.vn/stores/news_dataimages/lananh/092021/02/16/in_article/trung-quoc-trong-thanh-cong-lua-khong-lo-cao-hon-2-met.jpg?rt=20210902164658',
    idDease: 1,
    likes: 1202,
    comments: 184,
    shares: 96,
  ),
  Post(
    user: onlineUsers[5],
    caption:
        'Please enjoy this placeholder text: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    timeAgo: '3hr',
    imageUrl: "",
    idDease: 0,
    likes: 683,
    comments: 79,
    shares: 18,
  ),
  Post(
    user: onlineUsers[4],
    caption: 'This is a very good boi.',
    timeAgo: '8hr',
    imageUrl:
        'https://cdnmedia.baotintuc.vn/Upload/DMDnZyELa7xUDTdLsa19w/files/2021/08/lua-190821.jpg',
    idDease: 2,
    likes: 894,
    comments: 201,
    shares: 27,
  ),
  Post(
    user: onlineUsers[3],
    caption: 'Adventure 🏔',
    timeAgo: '15hr',
    imageUrl:
        'https://amthucbonmua.vn/wp-content/uploads/2020/11/canh-dong-lua.jpg',
    idDease: 3,
    likes: 722,
    comments: 183,
    shares: 42,
  ),
  Post(
    user: onlineUsers[0],
    caption:
        'More placeholder text for the soul: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    timeAgo: '1d',
    imageUrl: "",
    idDease: 0,
    likes: 482,
    comments: 37,
    shares: 9,
  ),
  Post(
    user: onlineUsers[9],
    caption: 'A classic.',
    timeAgo: '1d',
    imageUrl:
        'https://anphupet.com/wp-content/uploads/2021/03/cay-lua-cau-tao.jpg',
    idDease: 4,
    likes: 1523,
    shares: 129,
    comments: 301,
  )
];
