import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wiki_media_state.dart';

class WikiMediaCubit extends Cubit<WikiMediaState> {
  WikiMediaCubit() : super(WikiMediaInitial());
}
