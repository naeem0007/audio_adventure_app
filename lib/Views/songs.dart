import 'package:audio_adventure/Views/player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Consts/colors.dart';
import '../Consts/text_style.dart';
import '../Controller/player_controller.dart';

songsPlayer() {
  var controller = Get.put(PlayerController());
  return FutureBuilder<List<SongModel>>(
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
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Obx(
                    () => ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      tileColor: bgcolor,
                      title: Text(
                        snapshot.data![index].displayNameWOExt,
                        style: ourStyle(family: "Semibold", size: 14),
                        textAlign: TextAlign.start,
                      ),
                      subtitle: Text(
                        "${snapshot.data![index].artist}",
                        style: ourStyle(family: regular, size: 12),
                      ),
                      leading: QueryArtworkWidget(
                        id: snapshot.data![index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: const Icon(
                          Icons.music_note,
                          color: whitecolor,
                          size: 26,
                        ),
                      ),
                      trailing: controller.playIndex.value == index &&
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
                        controller.playSong(snapshot.data![index].uri, index);
                      },
                    ),
                  ));
            },
          ),
        );
      }
    },
  );
}
