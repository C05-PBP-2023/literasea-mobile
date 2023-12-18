import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/forum/models/question.dart';
import 'package:literasea_mobile/forum/screens/choose_book_qna.dart';
import 'package:literasea_mobile/forum/widgets/answer.dart';
import 'package:literasea_mobile/forum/util/fetch.dart';
import 'package:literasea_mobile/main.dart';

class QNAPage extends StatefulWidget {
  const QNAPage({Key? key}) : super(key: key);

  @override
  State<QNAPage> createState() => _QNAPageState();
}

class _QNAPageState extends State<QNAPage> {
  Future<List<Question>> _data = fetchQuestions();
  List<Question> listQuestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 60,
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: const Color(0xffd7e9f4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 44),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Questions and Answers",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff00134E),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Ask any questions about any book! Our writers may answer with what they know.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Color(0xff00134E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            title: Text(
              "Q & A",
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 24,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0.0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  color: Colors.black,
                  tooltip: "Add question",
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (context) => const QNAChooseBook(),
                          ),
                        )
                        .then(
                          (_) => setState(() {
                            _data = fetchQuestions();
                          }),
                        );
                  },
                ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(childCount: 1,
                (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Questions",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder(
                    future: _data,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 24.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        if (!snapshot.hasData) {
                          return const Column(
                            children: [
                              Text(
                                "There are no question datas.",
                                style: TextStyle(
                                    color: Color(0xff59A5D8), fontSize: 20),
                              ),
                              SizedBox(height: 8),
                            ],
                          );
                        } else {
                          return MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              reverse: true,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${snapshot.data![index].fullName}",
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff3992C6),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            snapshot.data![index].title == ""
                                                ? "(No title)"
                                                : "${snapshot.data![index].title}",
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "${snapshot.data![index].bookTitle} - ${snapshot.data![index].bookAuthor}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 4,
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            snapshot.data![index].question == ""
                                                ? "(Empty question)"
                                                : "${snapshot.data![index].question}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                height: 1.5,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          snapshot.data![index].answered
                                              ? TextButton(
                                                  style: TextButton.styleFrom(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 4),
                                                      minimumSize: Size.zero,
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "See answer",
                                                        style:
                                                            GoogleFonts.inter(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 1.0),
                                                        child: Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          size: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .vertical(
                                                          top: Radius.circular(
                                                              32),
                                                        ),
                                                      ),
                                                      showDragHandle: true,
                                                      isScrollControlled: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AnswerForm(
                                                          snapshot.data![index],
                                                        );
                                                      },
                                                    );
                                                  },
                                                )
                                              : UserInfo.data["type"] ==
                                                      "reader"
                                                  ? Text(
                                                      "This question is not yet answered.",
                                                      style: GoogleFonts.inter(
                                                        textStyle: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade500,
                                                        ),
                                                      ),
                                                    )
                                                  : TextButton(
                                                      style: TextButton.styleFrom(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 4),
                                                          minimumSize:
                                                              Size.zero,
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            "Answer question",
                                                            style: GoogleFonts
                                                                .inter(
                                                              textStyle:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xff3992C6),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 4),
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 1.0),
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              size: 14,
                                                              color: Color(
                                                                  0xff3992C6),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .vertical(
                                                              top: Radius
                                                                  .circular(32),
                                                            ),
                                                          ),
                                                          showDragHandle: true,
                                                          isScrollControlled:
                                                              true,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AnswerForm(
                                                              snapshot
                                                                  .data![index],
                                                            );
                                                          },
                                                        ).then(
                                                          (_) => setState(() {
                                                            _data =
                                                                fetchQuestions();
                                                          }),
                                                        );
                                                      },
                                                    )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 28),
                                    Image.network(
                                      "${snapshot.data![index].image}",
                                      fit: BoxFit.cover,
                                      width: 64,
                                      errorBuilder:
                                          ((context, error, stackTrace) {
                                        return Image.network(
                                          "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                                          width: 64,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
