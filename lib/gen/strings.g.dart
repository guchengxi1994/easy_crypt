/// Generated file. Do not edit.
///
/// Original: assets/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 40 (20 per locale)
///
/// Built on 2024-01-26 at 02:41 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	zhCn(languageCode: 'zh', countryCode: 'CN', build: _StringsZhCn.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _StringsLayoutEn layout = _StringsLayoutEn._(_root);
	late final _StringsEncryptionEn encryption = _StringsEncryptionEn._(_root);
}

// Path: layout
class _StringsLayoutEn {
	_StringsLayoutEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get encryption => 'Encryption';
	String get custom => 'Custom Algorithm';
	String get account => 'Account';
}

// Path: encryption
class _StringsEncryptionEn {
	_StringsEncryptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsEncryptionColumnEn column = _StringsEncryptionColumnEn._(_root);
	late final _StringsEncryptionTableEn table = _StringsEncryptionTableEn._(_root);
}

// Path: encryption.column
class _StringsEncryptionColumnEn {
	_StringsEncryptionColumnEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get no => 'No.';
	String get filepath => 'File Path';
	String get encryptedPath => 'Result Path';
	String get key => 'Password';
	String get createAt => 'Create At';
	String get operation => 'Operations';
}

// Path: encryption.table
class _StringsEncryptionTableEn {
	_StringsEncryptionTableEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get prev => 'Previous';
	String get next => 'Next';
	String get cpfilepath => 'Copy File Path';
	String get cpkey => 'Copy Password';
	String get startencrypt => 'Start';
	String get rmrecord => 'Remove Record';
	String get upto => 'Upload To';
	String get shareto => 'Share To';
	String get wx => 'Wechat';
	String get openfolder => 'Open Folder';
	String get rmfile => 'Remove File';
}

// Path: <root>
class _StringsZhCn implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsZhCn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zhCn,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-CN>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsZhCn _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsLayoutZhCn layout = _StringsLayoutZhCn._(_root);
	@override late final _StringsEncryptionZhCn encryption = _StringsEncryptionZhCn._(_root);
}

// Path: layout
class _StringsLayoutZhCn implements _StringsLayoutEn {
	_StringsLayoutZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get encryption => '文件加密';
	@override String get custom => '自定义加密算法';
	@override String get account => '账号';
}

// Path: encryption
class _StringsEncryptionZhCn implements _StringsEncryptionEn {
	_StringsEncryptionZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _StringsEncryptionColumnZhCn column = _StringsEncryptionColumnZhCn._(_root);
	@override late final _StringsEncryptionTableZhCn table = _StringsEncryptionTableZhCn._(_root);
}

// Path: encryption.column
class _StringsEncryptionColumnZhCn implements _StringsEncryptionColumnEn {
	_StringsEncryptionColumnZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get no => '编号';
	@override String get filepath => '文件路径';
	@override String get encryptedPath => '结果路径';
	@override String get key => '密钥';
	@override String get createAt => '创建时间';
	@override String get operation => '操作';
}

// Path: encryption.table
class _StringsEncryptionTableZhCn implements _StringsEncryptionTableEn {
	_StringsEncryptionTableZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get prev => '上一页';
	@override String get next => '下一页';
	@override String get cpfilepath => '复制文件路径';
	@override String get cpkey => '复制密钥';
	@override String get startencrypt => '开始';
	@override String get rmrecord => '删除记录';
	@override String get upto => '上传到...';
	@override String get shareto => '分享到...';
	@override String get wx => '微信';
	@override String get openfolder => '打开文件夹';
	@override String get rmfile => '删除文件';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'layout.encryption': return 'Encryption';
			case 'layout.custom': return 'Custom Algorithm';
			case 'layout.account': return 'Account';
			case 'encryption.column.no': return 'No.';
			case 'encryption.column.filepath': return 'File Path';
			case 'encryption.column.encryptedPath': return 'Result Path';
			case 'encryption.column.key': return 'Password';
			case 'encryption.column.createAt': return 'Create At';
			case 'encryption.column.operation': return 'Operations';
			case 'encryption.table.prev': return 'Previous';
			case 'encryption.table.next': return 'Next';
			case 'encryption.table.cpfilepath': return 'Copy File Path';
			case 'encryption.table.cpkey': return 'Copy Password';
			case 'encryption.table.startencrypt': return 'Start';
			case 'encryption.table.rmrecord': return 'Remove Record';
			case 'encryption.table.upto': return 'Upload To';
			case 'encryption.table.shareto': return 'Share To';
			case 'encryption.table.wx': return 'Wechat';
			case 'encryption.table.openfolder': return 'Open Folder';
			case 'encryption.table.rmfile': return 'Remove File';
			default: return null;
		}
	}
}

extension on _StringsZhCn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'layout.encryption': return '文件加密';
			case 'layout.custom': return '自定义加密算法';
			case 'layout.account': return '账号';
			case 'encryption.column.no': return '编号';
			case 'encryption.column.filepath': return '文件路径';
			case 'encryption.column.encryptedPath': return '结果路径';
			case 'encryption.column.key': return '密钥';
			case 'encryption.column.createAt': return '创建时间';
			case 'encryption.column.operation': return '操作';
			case 'encryption.table.prev': return '上一页';
			case 'encryption.table.next': return '下一页';
			case 'encryption.table.cpfilepath': return '复制文件路径';
			case 'encryption.table.cpkey': return '复制密钥';
			case 'encryption.table.startencrypt': return '开始';
			case 'encryption.table.rmrecord': return '删除记录';
			case 'encryption.table.upto': return '上传到...';
			case 'encryption.table.shareto': return '分享到...';
			case 'encryption.table.wx': return '微信';
			case 'encryption.table.openfolder': return '打开文件夹';
			case 'encryption.table.rmfile': return '删除文件';
			default: return null;
		}
	}
}
