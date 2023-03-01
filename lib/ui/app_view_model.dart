import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/ui/search_page/search_page.dart';

import 'auth_page/auth_page.dart';
import 'home_page/home_page.dart';

const List<StatefulWidget> pages = [HomePage(), SearchPage(), AuthPage()];

StateProvider<int> indexProvider = StateProvider((ref) => 0);
StateProvider<StatefulWidget> pageProvider = StateProvider((ref) => pages[0]);

void togglePage(WidgetRef ref, int index) {
  ref.watch(indexProvider.notifier).state = index;
  ref.watch(pageProvider.notifier).state = pages[index];
}
