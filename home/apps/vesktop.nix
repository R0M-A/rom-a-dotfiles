{ ... }:

# Huge Thanks to Coddo for the work in this file!
# https://github.com/coddo621/RabotNixOS/blob/main/home/apps/vesktop.nix
# Modified to suit my needs
let
  nativeTitleBar = false;
  disableMinSize = true;
  transparencyOption = "none"; # Windows only?
in
{
  programs.vesktop = {
    enable = true;
    mutableSettings = true;

    settings = {
      # https://github.com/Vencord/Vesktop/blob/main/src/shared/settings.d.ts
      discordBranch = "stable";
      autoStartMinimized = true;
      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
      hardwareVideoEncoding = true;

      inherit nativeTitleBar;
      staticTitle = false;
      enableMenu = false;
      enableShadow = true;
      enableRoundedCorners = false;
      enableSplashScreen = true;
      splashTheming = true;
      splashPixelated = false;
      # splashColor = "#ffffff";
      # splashBackground = "#000000";

      tray = true;
      minimizeToTray = true;
      clickTrayToShowHide = true;
      inherit disableMinSize;
      disableSmoothScroll = true;

      appBadge = true;
      enableTaskbarFlashing = false;

      arRPC = true;
      openLinksWithElectron = false;
      webRTCIPHandlingPolicy = "default_public_interface_only"; # One day "disable_non_proxied_udp" with SOCKS5 setup

      inherit transparencyOption;
      spellCheckLanguages = [
        "en-GB"
        "hr-HR"
        "ja-JP"
      ];

      audio = {
        workaround = false; # ???

        deviceSelect = true;
        granularSelect = true;

        ignoreVirtual = false;
        ignoreDevices = false;
        ignoreInputMedia = false;

        mute = true;
        # onlySpeakers = false;
        # onlyDefaultSpeakers = false;
      };
    };

    vencord = {
      mutableSettings = true;
      extraQuickCss = ''
        /* disable webcam preview mirroring */
        .media-engine-video { transform: none; }
      '';

      settings = {
        # https://github.com/Vendicated/Vencord/blob/main/src/api/Settings.ts
        autoUpdate = false;
        autoUpdateNotification = false;
        useQuickCss = true;
        eagerPatches = false; # Eagerly patching no longer works due to module factories with the same id being able to have different sources now.

#         enabledThemes = [];
        themeLinks = [];

        enableReactDevtools = false;
        frameless = true;
        transparent = true;
        winCtrlQ = false;
        macosVibrancyStyle = "";
        windowsMaterial = transparencyOption;
        inherit disableMinSize;
        inherit nativeTitleBar;

        # uiElements
        # notifications
        # cloud

        plugins = {
          AccountPanelServerProfile = {
            enabled = true;
            prioritizeServerProfile = true;
          };

          AddAttachments.enabled = true;
          AlwaysAnimate.enabled = true;
          AlwaysExpandRoles.enabled = true;

          AlwaysTrust = {
            enabled = true;
            domain = true;
            file = true;
          };

          AnonymiseFileNames = {
            enabled = false;
            anonymiseByDefault = true;
            method = "random";
            randomizedLength = 10;
            consistent = "";
          };

          #           AutoDNDWhilePlaying = {
          #             enabled = false;
          #           };

          BetterFolders = {
            enabled = true;
            sidebar = true;
            sidebarAnim = true;
            closeAllFolders = false;
            closeAllHomeButton = false;
            closeOthers = false;
            closeServerFolder = false;
            forceOpen = false;
            keepIcons = false;
            showFolderIcon = "Always";
          };

          BetterGifAltText.enabled = true;
          BetterGifPicker.enabled = true;

          BetterRoleContext = {
            enabled = true;
            roleIconFileFormat = "webp";
          };

          BetterRoleDot = {
            enabled = true;
            bothStyles = true;
            copyRoleColorInProfilePopout = true;
          };

          BetterSearch.enabled = true;

          BetterSessions = {
            enabled = true;
            backgroundCheck = true;
            checkInterval = 30;
          };

          BetterSettings = {
            enabled = true;
            disableFade = true;
            organizeMenu = true;
            eagerLoad = true;
          };

          BetterUploadButton.enabled = true;
          BiggerStreamPreview.enabled = true;

          BlurNSFW = {
            enabled = true;
            blurAmount = 10;
          };

          CallTimer = {
            enabled = true;
            format = "stopwatch";
          };

          CharacterCounter = {
            enabled = true;
            colorEffects = true;
          };

          ClearURLs.enabled = true;

          #           ClientTheme = {
          #             enabled = false;
          #           };

          #           ColorSighted.enabled = false;

          #           ConsoleJanitor = {
          #             enabled = false;
          #           };

          ConsoleShortcuts.enabled = true;

          CopyEmojiMarkdown = {
            enabled = true;
            copyUnicode = true;
          };

          CopyFileContents.enabled = true;
          CopyUserURLs.enabled = true;

          CrashHandler = {
            enabled = true;
            attemptToPreventCrashes = true;
            attemptToNavigateToHome = false;
          };

          CustomCommands.enabled = true; # add in future

          CustomIdle = {
            enabled = true;
            idleTimeout = 60;
            remainInIdle = true;
          };

          #           CustomRPC = {
          #             enabled = false;
          #           };

          #           Dearrow = {
          #             enabled = false;
          #           };

          Decor.enabled = true;
          DirectFileDownload.enabled = true;

          #           DisableCallIdle.enabled = false;

          DontRoundMyTimestamps.enabled = true;
          Experiments.enabled = true;

          ExpressionManager = {
            enabled = true;
            editAndDelete = true;
            stickerCopyAndOpen = true;
            recents = true;
          };

          #           F8Break.enabled = false;

          FakeNitro = {
            enabled = true;
            enableEmojiBypass = true;
            emojiSize = 48;
            transformEmojis = true;
            enableStickerBypass = true;
            stickerSize = 160;
            transformStickers = true;
            transformCompoundSentence = false;
            enableStreamQualityBypass = true;
            useHyperLinks = true;
            hyperLinkText = "{{NAME}}";
            disableEmbedPermissionCheck = false;
          };

          FakeProfileThemes = {
            enabled = true;
            nitroFirst = true;
          };

          FavoriteEmojiFirst.enabled = true;
          FixCodeblockGap.enabled = true;

          FixImagesQuality = {
            enabled = true;
            originalImagesInChat = false;
          };

          FixSpotifyEmbeds = {
            enabled = true;
            volume = 10;
          };

          FixYoutubeEmbeds.enabled = true;
          ForceOwnerCrown.enabled = true;
          FriendInvites.enabled = true;
          FullSearchContext.enabled = true;

          GameActivityToggle = {
            enabled = true;
            oldIcon = false;
          };

          GifPaste.enabled = true;
          GifProviderSwitcher.enabled = true;

          GreetStickerPicker = {
            enabled = true;
            greetMode = "Greet";
          };

          HideMedia.enabled = true;
          IgnoreActivities.enabled = false;
          ILoveSpam.enabled = false;
          ImageFilename = {
            enabled = true;
            showFullUrl = true;
          };

          #           ImageLink.enabled = false;

          ImageZoom = {
            enabled = true;
            saveZoomValues = false;
            invertScroll = false;
            nearestNeighbour = true;
            square = true;
            zoom = 2;
            size = 100;
            zoomSpeed = 0.5;
          };

          ImplicitRelationships = {
            enabled = true;
            sortByAffinity = true;
          };

          #           IrcColors = {
          #             enabled = false;
          #           };

          JumpToTop.enabled = true;

          #           KeepCurrentChannel.enabled = false;

          #           LoadingQuotes = {
          #             enabled = false;
          #           };

          MemberCount = {
            enabled = true;
            toolTip = true;
            memberList = true;
            voiceActivity = true;
          };

          MentionAvatars = {
            enabled = true;
            showAtSymbol = true;
          };

          MessageClickActions = {
            enabled = true;
            enableDeleteOnClick = true;
            enableDoubleClickToEdit = true;
            enableDoubleClickToReply = true;
            requireModifier = false;
          };

          MessageLatency = {
            enabled = true;
            latency = 2;
            detectDiscordKotlin = true;
            showMillis = true;
            ignoreSelf = false;
          };

          MessageLinkEmbeds = {
            enabled = true;
            messageBackgroundColor = true;
            automodEmbeds = "never";
          };

          # Againt GDPR
          MessageLogger = {
            enabled = false;
          };

          MoreQuickReactions = {
            enabled = true;
            reactionCount = 13;
          };

          #           MusicRichPresence = {
          #             enabled = false;
          #           };

          MutedServersActivityBadge.enabled = true;
          MutualGroupDMs.enabled = true;

          NewGuildSettings = {
            enabled = true;
            guild = true;
            messages = 1;
            everyone = false;
            role = false;
            highlights = true;
            events = false;
            showAllChannels = true;
          };

          #           NoBlockedMessages = {
          #             enabled = false;
          #           };

          NoDevtoolsWarning.enabled = true;
          NoF1.enabled = true;
          #           NoMaskedUrlPaste.enabled = false;
          #           NoMiddleClickPaste.enabled = false;

          NoMosaic = {
            enabled = true;
            inlineVideo = true;
          };

          NoOnboardingDelay.enabled = true;

          NoPendingCount = {
            enabled = true;
            hideFriendRequestCount = false;
            hideMessageRequestCount = false;
            hidePremiumOffersCount = true;
          };

          #           NoProfileThemes.enabled = false;

          #           NoReplyMention = {
          #             enabled = false;
          #           };

          #           NoServerEmojis = {
          #             enabled = false;
          #           };

          NotificationVolume = {
            enabled = true;
            notificationVolume = 75;
          };

          NoTypingAnimation.enabled = true;
          NoUnblockToJump.enabled = true;
          oneko.enabled = false;

          OnePingPerDM = {
            enabled = true;
            channelToAffect = "both_dms";
            allowMentions = true;
            allowEveryone = true;
          };

          #           OpenInApp.enabled = false;

          #           OverrideForumDefaults = {
          #             enabled = false;
          #           };

          PauseInvitesForever.enabled = true;

          PermissionFreeWill = {
            enabled = true;
            lockout = true;
            onboarding = true;
          };

          PermissionsViewer = {
            enabled = true;
            permissionsSortOrder = "HighestRole";
          };

          petpet.enabled = true;

          PictureInPicture = {
            enabled = true;
            loop = false;
          };

          PinDMs = {
            enabled = true;
            pinOrder = 0;
            canCollapseDmSection = true;
          };

          PlainFolderIcon.enabled = false;
          PlatformIndicators.enabled = false;
          PreviewMessage.enabled = true;
          QuickMention.enabled = true;

          QuickReply = {
            enabled = true;
            shouldMention = 2;
            ignoreBlockedAndIgnored = true;
          };

          ReactErrorDecoder.enabled = true;
          ReadAllNotificationsButton.enabled = true;

          RelationshipNotifier = {
            enabled = true;
            notices = false;
            offlineRemovals = true;
            friends = true;
            friendRequestCancels = true;
            servers = true;
            groups = true;
          };

          ReplaceGoogleSearch = {
            enabled = true;
            replacementEngine = "OFF";
          };

          ReplyTimestamp.enabled = true;
          RevealAllSpoilers.enabled = true;
          ReverseImageSearch.enabled = true;

          #           ReviewDB = {
          #             enabled = false;
          #           };

          RoleColorEverywhere = {
            enabled = true;
            chatMentions = true;
            memberList = true;
            voiceUsers = true;
            reactorsList = true;
            pollResults = true;
            colorChatMessages = false;
            messageSaturation = 30;
          };

          #           SecretRingToneEnabler.enabled = false;

          SendTimestamps = {
            enabled = true;
            replaceMessageContents = true;
          };

          ServerInfo.enabled = true;

          ServerListIndicators = {
            enabled = true;
            mode = 3;
          };

          ShikiCodeblocks = {
            enabled = true;
            #theme = "";
            #customTHeme = "";
            tryHljs = "Always";
            useDevIcon = "Color";
            bgOpacity = 75;
          };

          ShowAllMessageButtons.enabled = false;

          #           ShowConnections = {
          #             enabled = false;
          #           };

          ShowHiddenThings = {
            enabled = true;
            showTimeouts = true;
            showInvitesPaused = true;
            showModView = true;
          };

          ShowMeYourName = {
            enabled = true;
            mode = "nick-user";
            friendNicknames = "dms";
            displayNames = false;
            inReplies = false;
          };

          ShowTimeoutDuration = {
            enabled = true;
            displayStyle = "ssalggnikool";
          };

          SilentMessageToggle = {
            enabled = true;
            persistState = false;
            autoDisable = true;
          };

          #           SilentTyping = {
          #             enabled = false;
          #           };

          SortFriendRequests = {
            enabled = true;
            showDates = true;
          };

          SpotifyControls = {
            enabled = true;
            hoverControls = false;
            useSpotifyUris = false;
            previousButtonRestartsTrack = false;
          };

          SpotifyCrack = {
            enabled = true;
            noSpotifyAutoPause = true;
            keepSpotifyActivityOnIdle = true;
          };

          SpotifyShareCommands.enabled = true;
          StartupTimings.enabled = true;
          StickerPaste.enabled = true;
          StreamerModeOnStream.enabled = true;

          SuperReactionTweaks = {
            enabled = true;
            superReactByDefault = false;
            unlimitedSuperReactionPlaying = true;
            superReactionPlayingLimit = 20;
          };

          #           TextReplace.enabled = false;
          ThemeAttributes.enabled = true;

          Translate = {
            enabled = true;
            service = "google";
            autoTranslate = false;
            showAutoTranslateTooltip = true;
            receivedInput = "auto";
            receivedOutput = "en";
            sentInput = "auto";
            sentOutput = "en";
          };

          TypingIndicator = {
            enabled = false;
          };

          TypingTweaks = {
            enabled = true;
            showAvatars = true;
            showRoleColors = true;
            alternativeFormatting = true;
          };

          Unindent.enabled = true;

          UnlockedAvatarZoom = {
            enabled = true;
            zoomMultiplier = 4;
          };

          UnsuppressEmbeds.enabled = true;

          UserMessagesPronouns = {
            enabled = true;
            pronounsFormat = "LOWERCASE";
            showSelf = true;
          };

          UserVoiceShow = {
            enabled = true;
            showInUserProfileModal = true;
            showInMemberList = true;
            showInMessages = true;
          };

          USRBG = {
            enabled = true;
            nitroFirst = "true";
            voiceBackground = true;
          };

          ValidReply.enabled = true;
          ValidUser.enabled = true;
          #           VcNarrator.enabled = false;

          VencordToolbox = {
            enabled = true;
            showPluginMenu = true;
          };

          ViewIcons = {
            enabled = true;
            format = "webp";
            imgSize = "4096";
          };

          ViewRaw = {
            enabled = true;
            clickMethod = "Left";
            messageContext = true;
            sortKeys = true;
            stripSensitiveData = false;
          };

          VoiceChatDoubleClick.enabled = true;
          VoiceDownload.enabled = true;
          VoiceMessages.enabled = true;

          VolumeBooster = {
            enabled = true;
            multiplier = 5;
          };

          WebKeybinds = {
            enabled = true;
            showNavigationButtons = true;
            overrideCommonKeybinds = true;
          };

          WebScreenShareFixes = {
            enabled = true;
            experimentalAV1Support = true;
            betterCodecs = true;
          };

          #           WhoReacted = {
          #             enabled = false;
          #           };

          #           XSOverlay.enabled = false;

          YoutubeAdblock.enabled = true;

          NoTrack = {
            enabled = true;
            disableAnalytics = true;
            allowBadgeTracking = true;
          };

          Settings = {
            enabled = true;
            settingsLocation = "aboveNitro";
            includeVencordInfoWhenCopying = true;
          };
        };
      };
      useSystem = false;
    };
  };
}
