import 'package:audio_adventure/Consts/colors.dart';
import 'package:audio_adventure/Controller/player_controller.dart';
import 'package:audio_adventure/Views/player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Consts/text_style.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          backgroundColor: bgDarkColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: whitecolor,
                ))
          ],
          leading: Image.asset(
            logo,
            width: 100,
          ),
          title: Text(
            "Audio Adventure",
            style: ourStyle(family: bold, size: 18, color: whitecolor),
          ),
        ),
        bottomNavigationBar: Container(
          height: 54,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              var iconList = [
                Icons.email,
                Icons.favorite,
                Icons.home,
                Icons.notification_add,
                Icons.person
              ];
              return Transform.scale(
                scale: 1.2,
                child: Icon(
                  iconList[index],
                  color: whitecolor,
                ),
              );
            }),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TabBar(
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white.withOpacity(0.5),
                  tabs: const [
                    Tab(
                      text: "Songs",
                    ),
                    Tab(
                      text: "Playlists",
                    ),
                    Tab(
                      text: "Album",
                    ),
                    Tab(
                      text: "Artist",
                    ),
                  ]),
              Expanded(
                child: TabBarView(children: [
                  FutureBuilder<List<SongModel>>(
                    future: controller.audioQuery.querySongs(
                        ignoreCase: true,
                        orderType: OrderType.ASC_OR_SMALLER,
                        sortType: null,
                        uriType: UriType.EXTERNAL),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            "No Song Found",
                            style: ourStyle(),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            // physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  margin: const EdgeInsets.only(bottom: 4),
                                  child: Obx(
                                    () => ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      tileColor: bgcolor,
                                      contentPadding: const EdgeInsets.all(8),
                                      title: Text(
                                        snapshot.data![index].displayNameWOExt,
                                        style: ourStyle(
                                            family: "Semibold", size: 14),
                                        textAlign: TextAlign.start,
                                      ),
                                      subtitle: Text(
                                        "${snapshot.data![index].artist}",
                                        style:
                                            ourStyle(family: regular, size: 12),
                                      ),
                                      leading: QueryArtworkWidget(
                                        id: snapshot.data![index].id,
                                        type: ArtworkType.AUDIO,
                                        nullArtworkWidget: const Icon(
                                          Icons.music_note,
                                          color: whitecolor,
                                          size: 32,
                                        ),
                                      ),
                                      trailing:
                                          controller.playIndex.value == index &&
                                                  controller.isPlaying.value
                                              ? const Icon(
                                                  Icons.play_arrow,
                                                  color: whitecolor,
                                                  size: 26,
                                                )
                                              : null,
                                      onTap: () {
                                        Get.to(
                                            () => Player(
                                                  data: snapshot.data!,
                                                ),
                                            transition: Transition.downToUp);
                                        controller.playSong(
                                            snapshot.data![index].uri, index);
                                      },
                                    ),
                                  ));
                            },
                          ),
                        );
                      }
                    },
                  ),
                  Center(
                    child: Text(
                      "No Playlist created",
                      style: ourStyle(color: whitecolor),
                    ),
                  ),
                  Center(
                    child: Text(
                      "No Album created",
                      style: ourStyle(color: whitecolor),
                    ),
                  ),
                  Center(
                    child: Text(
                      "No Artist created",
                      style: ourStyle(color: whitecolor),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
