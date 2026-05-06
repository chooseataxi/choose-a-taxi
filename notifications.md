# OneSignal Notification Channels Setup Guide

This guide explains how to configure structured notification channels (boxes) for the ChooseATaxi application to ensure a professional and organized notification experience.

## 1. OneSignal Dashboard Configuration

For each of the 6 notification boxes, you need to create a **Notification Category (Channel)** in the OneSignal Dashboard.

### Steps to Create a Channel:
1. Log in to your [OneSignal Dashboard](https://dashboard.onesignal.com/).
2. Select your App.
3. Go to **Settings** -> **Platforms** -> **Google Android**.
4. Scroll down to the **Notification Categories** section.
5. Click **+ Add Category** for each of the following:

| Box Number | Category Name | Importance | Description |
|:---:|---|---|---|
| **Box-1** | New Bookings | High (Urgent) | Alerts for new available trips |
| **Box-2** | Chat Messages | High | Direct messages from other partners |
| **Box-3** | Commission Requests | High | Requests for commission payments |
| **Box-4** | Booking Accepted | High | Notifications when your booking is accepted |
| **Box-5** | Booking Cancelled | High | Alerts for trip cancellations |
| **Box-6** | Trip Status Updates| Default | Updates for Trip Start and Completion |

> [!TIP]
> You can assign different notification sounds to each category within the OneSignal dashboard if desired.

## 2. Admin Panel Configuration

Once you have created the categories, you will see a **Category ID** (or Channel ID) for each.

1. Go to your **Admin Panel** -> **Manage API** -> **OneSignal Channels**.
2. Enter the **OneSignal App ID** and **REST API Key**.
3. Copy the **Channel IDs** from OneSignal and paste them into the corresponding fields in the Admin Panel:
   - `Box-1: New Booking Channel ID`
   - `Box-2: Chat Message Channel ID`
   - `Box-3: Commission Request Channel ID`
   - `Box-4: Booking Accept Channel ID`
   - `Box-5: Booking Cancel Channel ID`
   - `Box-6: Trip Status Channel ID`
4. Click **Save All Channels & Settings**.

## 3. Testing the Setup

You can test each channel directly from the Admin Panel:
1. Scroll down to the **Test Channels (Boxes)** section.
2. Select the Box you want to test from the dropdown.
3. Enter a test title and message.
4. Click **Send Channel Test Push**.
5. Verify on your mobile device that the notification appears and is categorized correctly (you can check this in the Android notification settings for the app).

## 4. Message Formats

The system automatically uses professional templates for each box:

- **New Bookings (Box-1)**:
  ```
  1__ Oneway Trip booking (1024)
  Delhi ----- Agra
  Car type :- Sedan
  Date :- 07/05/26 @ 6 pm
  ```
- **Chats (Box-2)**: Standard message format with Sender Name and Message.
- **Trip Updates (Box-6)**: Clear status updates for "Started" and "Completed".

---
*Created by Antigravity AI Coding Assistant*
