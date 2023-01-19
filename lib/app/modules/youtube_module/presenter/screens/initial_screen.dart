import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube/general/constants.dart';
import 'package:youtube_api/youtube_api.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

TextEditingController _controller = TextEditingController();
YoutubeAPI ytbAPI = YoutubeAPI(Constants.apiKey, maxResults: 20);
List<YouTubeVideo> results = [];
bool isLoaded = false;

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    callApi();
  }

  Future<void> callApi({String search = ''}) async {
    try {
      results = await ytbAPI.search(search);

      setState(() {
        isLoaded = true;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: isLoaded
            ? TextFormField(
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: 'Pesquisar',
                  suffixIconColor: Colors.grey,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        callApi(search: _controller.text);
                      });
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
                controller: _controller,
              )
            : const Text('Youtube'),
        leading: const Icon(
          FeatherIcons.youtube,
          size: 28,
        ),
      ),
      body: isLoaded
          ? ListView.builder(
              itemCount: results.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    Uri url = Uri.parse(results[index].url);

                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    } else {
                      throw 'Não foi possível encontrar a URL: $url';
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(28),
                                  topRight: Radius.circular(28),
                                ),
                                child: Image.network(
                                  results[index].thumbnail.medium.url!,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        results[index].title,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      results[index].channelTitle,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  bottom: 15,
                                  top: 10,
                                ),
                                child: results[index].duration != null
                                    ? Text(
                                        'Duração do vídeo: ${results[index].duration!}',
                                        style: const TextStyle(fontSize: 12),
                                      )
                                    : const Text(
                                        'Canal do Youtube',
                                        style: TextStyle(fontSize: 12),
                                      ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  customColors: CustomSliderColors(
                    trackColor: Colors.red,
                    progressBarColor: Colors.red,
                  ),
                  spinnerMode: true,
                  size: 40,
                ),
              ),
            ),
    );
  }
}
