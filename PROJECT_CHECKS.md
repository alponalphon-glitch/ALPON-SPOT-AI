# Project checks — 4D scanner update

- Updated the existing Kotlin/Jetpack Compose project; did not replace it with a new project.
- Added layered navy gradient cards and elevation/shadow styling for a deeper premium visual treatment.
- Reworked Scanner to show the selected Binance Spot pair's real candlesticks first, with green bullish and red bearish candles and volume bars.
- Scanner chart refreshes the selected pair through Binance public REST data every 15 seconds and follows the selected timeframe (15m, 1h, 4h, 1d).
- Added the requested three-position control below the chart: Chart (default/first), Analysis (middle), Scanner (last).
- Scanner results remain selectable; choosing a result switches the live chart to that pair.
- Added a source backup: `MainActivity.kt.backup-before-4d-scanner`.
- Static delimiter check passed.
- A full Android Gradle compile was not run in this environment; the original archive does not contain a Gradle wrapper distribution or wrapper JAR, and Gradle is not installed here. GitHub Actions remains configured to provision Gradle 8.9 and build the APK.

# Trade analysis and risk-management update — 2026-11-19

- Expanded the technical engine to 123 calculated indicator / price-action readings across multiple lookback periods and analysis groups.
- Added moving-average, RSI, ROC, momentum, Bollinger, Stochastic, Williams %R, CCI, ATR, MFI, OBV, volume-ratio, ADX/DI, Donchian, Aroon, CMF, MACD variants, Ichimoku, VWAP, pivot and candle-pattern checks.
- Signal scoring now balances indicator families so one family with many parameter variants does not dominate the result.
- Indicator calculations exclude the newest potentially open Binance kline when sufficient candle history is available.
- Added timeframe-aware candle-close clock and rough review/holding window, plus confirmation-based entry guidance.
- Added Stop Loss, TP1/TP2/TP3, risk/reward, account balance input, risk percentage input, cash-at-risk and position-size calculation to the middle Analysis tab.
- Spot SELL guidance is explicitly framed as a possible exit/reduction for existing holdings, not a short instruction.
- Verified the technical-analysis Kotlin source compiles with `kotlinc` against the Candle model; a 300-candle local test produced 123 readings.
- Full Android/Compose Gradle build remains unverified because Gradle and its wrapper JAR/distribution are not available in this environment. GitHub Actions is configured to provision Gradle 8.9.

## 2026-11-19 — adaptive menu and language settings update

- Added a top-right three-line menu with My account, Settings, and Support destinations.
- Added a return control for secondary pages; bottom navigation remains available on the primary app screens.
- Added a device-persistent language selector with 20 language choices.
- Localized the primary navigation, menu, account, and settings labels for the included language dictionaries.
- Added a local-only display-name profile; no Binance login or exchange credentials are collected.
- Added a Telegram support action using the configured Alpon support handle.
- Kept the Compose layout based on `fillMaxSize`, system-safe Scaffold insets, and scrollable settings/profile content for varying phone dimensions.
- Created `MainActivity.kt.backup-before-menu-localization` before editing.

Build verification: not completed in this environment. `./gradlew :app:assembleDebug` was attempted but Gradle 8.9 could not be downloaded because DNS/network access to `services.gradle.org` was unavailable. Kotlin syntax scan found no parser errors, but this is not a substitute for an Android Gradle build. The 20-language picker is present; in this update the primary navigation/menu/settings/account labels are localized, while trading-specific analysis copy remains English pending full translation review.

## Continuous analysis update (2026-11-19)
- Home dashboard refreshes the selected Binance Spot symbol and its closed-candle technical analysis every 15 seconds while the app is open.
- Scanner opportunity results refresh every 60 seconds while the Scanner tab is open.
- The active, still-forming Binance kline is excluded from the technical-analysis input to reduce signal repainting; a new confirmed signal can therefore appear after a candle closes, not on every polling cycle.
- Home now exposes the full indicator-reading matrix grouped by indicator family.
- Removed the product name from the in-app menu/page header and Support/About menu copy; package identifiers remain unchanged.
- The technical-analysis Kotlin source was compiled independently with Kotlin 1.9.0 against the project's Candle data model. Full Android/Compose Gradle build was not run in this environment.

## Binance Spot market selector update (2026-11-19)
- Added Binance `GET /api/v3/exchangeInfo` metadata retrieval.
- Market selector now builds a live list of up to 500 USDT-quoted Spot symbols whose exchange status is `TRADING` and whose Spot permission is not explicitly disabled.
- Joined eligible symbols with live `GET /api/v3/ticker/24hr` data and sorted them by 24-hour quote volume; excluded common leveraged-token suffixes (UP/DOWN/BULL/BEAR).
- Added a searchable market picker above the Home chart and Scanner chart. Selecting a pair switches the active symbol and reloads ticker, candles, and analysis from Binance.
- The list is exchange-driven, not a hard-coded list. The actual number can be below 500 when fewer eligible pairs are returned or Binance/network access is unavailable.
- ZIP integrity can be checked locally; a full Android Gradle build has not been run in this environment.
