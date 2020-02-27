import 'package:scoped_model/scoped_model.dart';

import './connected-model.dart';
import './media-model.dart';

class MainModel extends Model with ConnectedModel, MediaModel {}