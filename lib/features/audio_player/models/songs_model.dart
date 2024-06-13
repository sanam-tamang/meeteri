class Song {
  String name;
  String audioNum;
  String time;
  String producer;
  bool isFav;

  Song({
    required this.name,
    required this.audioNum,
    required this.time,
    required this.producer,
    required this.isFav,
  });
}

List<Song> songs = [
  Song(
    name: 'To Speak of Solitude',
    audioNum: '01',
    time: '4:21',
    producer: 'Brambles',
    isFav: false,
  ),
  Song(
    name: 'Unsayable',
    audioNum: '02',
    time: '2:52',
    producer: 'Brambles',
    isFav: false,
  ),
  Song(
    name: 'In the Androgynous Dark',
    audioNum: '03',
    time: '4:43',
    producer: 'Brambles',
    isFav: true,
  ),
  Song(
    name: 'Salt Photographs',
    audioNum: '04',
    time: '6:54',
    producer: 'Brambles',
    isFav: false,
  ),
  Song(
    name: 'Pink And Golden Billows',
    audioNum: '05',
    time: '2:28',
    producer: 'Brambles',
    isFav: true,
  ),
  Song(
    name: 'Cutting Through',
    audioNum: '06',
    time: '4:12',
    producer: 'Brambles',
    isFav: false,
  ),
  Song(
    name: 'Redemption',
    audioNum: '07',
    time: '3:21',
    producer: 'Brambles',
    isFav: false,
  ),
  Song(
    name: 'You Make Me Fly',
    audioNum: '08',
    time: '5:10',
    producer: 'Brambles',
    isFav: true,
  ),
  Song(
    name: 'Dusk Till Dawn',
    audioNum: '09',
    time: '4:11',
    producer: 'Brambles',
    isFav: true,
  ),
  Song(
    name: 'My Life Goes On',
    audioNum: '10',
    time: '7:12',
    producer: 'Brambles',
    isFav: false,
  ),
];
