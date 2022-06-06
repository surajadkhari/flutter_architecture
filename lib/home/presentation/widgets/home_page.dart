import 'package:flutter/material.dart';
import 'package:flutter_architecture/home/presentation/controllers/posts_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homepage extends ConsumerWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(postNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fetch API with StateNotifier with Architecture"),
      ),
      body: RefreshIndicator(
        onRefresh: (() async {
          ref.refresh(postNotifierProvider);
        }),
        child: data.when(
            data: (result) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ...result.map((e) => ListTile(
                          title: Text(e.title.toUpperCase()),
                          subtitle: Text(e.body),
                        ))
                  ],
                ),
              );
              // return result.fold((l) => Text(l.message), (r) {
              //   return SingleChildScrollView(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         ...r.map((e) => ListTile(
              //               title: Text(e.title.toUpperCase()),
              //               subtitle: Text(e.body),
              //             ))
              //       ],
              //     ),
              //   );
              // });
            },
            error: (e, s) => Text(e.toString()),
            loading: () => const Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
