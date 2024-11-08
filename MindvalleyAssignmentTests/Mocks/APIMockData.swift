//
//  APIMockData.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 08/11/24.
//

import Foundation

// MARK: - Test Data
class APIMockData {
    // Channel Response Data
    static let channelsJSON = """
    {
      "data": {
        "channels": [
          {
            "title": "Mindvalley Mentoring",
            "series": [],
            "mediaCount": 98,
            "latestMedia": [
              {
                "type": "course",
                "title": "How Journaling Helped Create a $500M Company",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/a90653b8-8475-41a9-925a-3a1bf0e7cd5f.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "The Truth About Water",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/c3b924a1-7e33-4175-9647-95d011b986ba.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Vishen's Optimized Morning Routine",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/953f74d2-52a9-4769-9369-04849e786bb4.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "What To Eat For A Genius Brain",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/bff42af7-5a7e-46fb-bcda-7eb7dc3fb342.jpg"
                }
              },
              {
                "type": "course",
                "title": "How to invest like a Buffett",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/8eb890f6-4d88-48cc-9af5-a207dd90913e.jpg"
                }
              },
              {
                "type": "course",
                "title": "How to Nurture Greatness In Your Kids",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/eaa7aad0-3036-43fd-b446-3128b78aaef1.jpg"
                }
              },
              {
                "type": "course",
                "title": "A Framework For Spiritual Activism",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/841c723f-2a56-47d3-a96b-3cc6747ffc56.jpg"
                }
              },
              {
                "type": "course",
                "title": "How to Live to Be 180",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/1265e870-86e4-45ed-bea3-c09cd6ee8932.jpg"
                }
              },
              {
                "type": "course",
                "title": "How to Optimize Your Nutrition",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/9de12ffd-d357-4306-9c58-dbe764849f3d.jpg"
                }
              },
              {
                "type": "course",
                "title": "From Suffering to Manifesting",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/abd4378b-7714-488c-a234-29c7e27b0a73.jpg"
                }
              },
              {
                "type": "course",
                "title": "How to Live in Awe",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/fc2992cf-bf78-470a-afb8-de444e42c25f.jpg"
                }
              },
              {
                "type": "course",
                "title": "The Cure for Loneliness",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/830808f0-e488-49a5-8ac6-960c7b38aa2f.jpg"
                }
              }
            ],
            "id": "11",
            "iconAsset": {
              "thumbnailUrl": "https://edgecastcdn.net/80EC13/public/overmind2/asset/11914f01-ba4a-4d68-9c33-efb34c43ed23/channel-icon-mentoring_thumbnail.png"
            },
            "coverAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/8fd5837a-539c-4367-b1af-8579a3e3d461.jpg?transform=w_1080"
            }
          },
          {
            "title": "Mentoring At Work",
            "series": [],
            "mediaCount": 33,
            "latestMedia": [
              {
                "type": "course",
                "title": "Becoming Indistractable",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/8cbd2545-4e13-4e20-aa8a-a693ddeb0915.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Applied Mindfulness at Work",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/fdd18708-e4e8-4d42-824e-4b2b5a0ff43f.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "The Journey To Marketing Automation",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/fa3323d4-3cc2-4da4-acc8-2f7cce8c56de.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Understanding Business Growth Stage",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/a03aaaa5-35f1-4a17-ac4f-7a782fe0fe46.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Getting Press and Publicity for Free",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/9a4bd5fd-e2d5-4b84-9580-c8da949ea8e3.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Principles of Organizational Health",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/9bee075a-0a13-4d59-ad96-91fbe5693972.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "The Power of Critical Thinking",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/9bfa6d9a-0a79-40ab-ace6-67dbda36bbff.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Level Up your Sales Mindset",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/596982af-0faf-4625-bbf2-3d42b8642445.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Productivity in the Age of Distraction",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/5ad01ac4-8811-4ac2-9c08-29563e128e68.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Building Trust and Transparency in Marketing",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/9cb6d9fb-3a75-4269-b9ef-bbbf418e7f3c.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Grow Your Reach the LinkedIn Way",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/2cad8fe1-3d10-450a-a881-40061c465b37.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Evolved Enterprise",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/c5c3c305-bcd4-4ea6-8b5b-273bee9a1e37.jpg?transform=w_1080"
                }
              }
            ],
            "iconAsset": {
              "thumbnailUrl": "https://edgecastcdn.net/80EC13/public/overmind2/asset/a4d257e4-c254-46c0-8378-0873416d896f/channel-icon-impact_thumbnail.png"
            },
            "coverAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/c6e51f96-2638-4320-8f77-81ea12cc0f65.jpg?transform=w_1080"
            }
          },
          {
            "title": "Lifebook Membership",
            "mediaCount": 173,
            "series":[],
            "latestMedia": [
              {
                "type": "course",
                "title": "Recorded Live Calls: Intellectual Life",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/273a5e20-8088-4e94-8f34-6b0241e93962.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Jon's Audio: Utilizing Your Intellect to Optimize Your Habits with Jon Butcher",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/ce00ea78-58f6-476b-8613-3368301e586a.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Featured Expert: Kwik Intellectual Insights with Jim Kwik",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/6d41445d-a2a4-4aa7-a3a3-a8eb0e85d0e0.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Featured Member: Cultivating a Lifelong Love of Learning with Alexandru Surdu",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/4021da9d-1cb9-492d-887e-9d6567eea7dd.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Intellectual Life Challenge: Kwik Learning with Jim Kwik",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/96c2f2b2-022a-4d3e-8036-80a5084ea71a.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "LifeNotes: The Miracle of Mindfulness by Thich Nhat Hanh",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/ae29196b-f3d0-4f02-b2e6-1d5b20e1fb5d.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Featured Experts: From Flow States to Flow Consciousness with Jackie Knechtel and Justin Faerman",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/c28084f8-948e-468c-b11d-00706854fa73.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Let thy Food be thy Medicine, with Dr. Steven Helschein",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/0225e947-2f8d-45f5-b04e-99357dad39b6.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Recorded Live Calls: Health & Fitness",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/f5bf0341-ec3b-4dde-97dd-81b5c924c0e1.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Expert Interview: Transforming our Relationship with Food with Eric Edmeades",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/63a2bebe-93d8-4d2b-8583-a1297dea3fe0.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Expert Interview: The Four Pillars of Wellness with Ronan Diego de Oliveira",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/27541a31-3f27-4c44-b232-02ecc350e8ea.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Jon's Audio: The Power of Purpose with Jon Butcher",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/626bc49a-8fdf-4415-bc20-78971ce5362c.jpg?transform=w_1080"
                }
              }
            ],
            "id": "10",
            "iconAsset": {
              "thumbnailUrl": "https://edgecastcdn.net/80EC13/public/overmind2/asset/81adb71d-bd2f-48dc-bd8a-e4e4d05027bd/channel-icon-lifebook_thumbnail.png"
            },
            "coverAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/2ff8c6ba-9ee7-4a37-83d1-059da78d6fac.jpg?transform=w_1080"
            }
          },
          {
            "title": "Coaching Mastery by Evercoach",
            "series": [
              {
                "title": "Coaching Mastery by Evercoach",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/049742c3-9489-40b0-a415-e80976cd710b.jpg?transform=w_1080"
                }
              },
              {
                "title": "Bonus Trainings",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/8e35036a-50f8-42d0-8dbf-a55034a0053f.jpg?transform=w_1080"
                }
              }
            ],
            "mediaCount": 27,
            "latestMedia": [
              {
                "type": "course",
                "title": "Emotional Health",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/b33f048f-50e5-4f22-870a-f40e3c9d0b28.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Principle-Based Coaching",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/beca87c5-7c4b-416d-a9a3-d019b3e143a7.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Deep Listening",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/06e42a8f-7a3a-442f-a80f-376501fef3a8.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Inner Strengths and Emotional Intelligence",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/d1c81222-aaab-423d-b0e7-2bb8e55c5f09.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Self Coaching",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/f22e58f8-359e-4c60-85e0-d94a1bb4f0b4.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Metaphors and Distinctions",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/686272f9-6f14-4667-95c5-7b4a0353055b.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Effective Communication",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/b3eb5839-fa51-4eb5-b97e-d3a8de85f7c3.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Boundaries",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/66299b09-f955-4771-97cd-66c61b7a0651.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Human Behavior",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/0cd57680-4af2-49fa-af00-51fe6f5f4458.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Awareness and Presence",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/23bb3034-7c56-4b21-a842-9d3b75c826b1.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Live Calls with Ajit Nawalkha",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/d020f275-dabe-4c7c-955e-6f5ece5e3ca5.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Beyond",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/3a235d6b-fa61-488c-99c2-5b6740773fa4.jpg?transform=w_1080"
                }
              }
            ],
            "iconAsset": {
              "thumbnailUrl": "https://edgecastcdn.net/80EC13/public/overmind2/asset/5f680a18-5d09-40bf-88b6-23c0a69b4a46/channel-icon-coaching-mastery_thumbnail.png"
            },
            "coverAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/9ea03476-36c4-4358-a784-75f4cce0e2ad.jpg?transform=w_1080"
            }
          },
          {
            "title": "Mindvalley Films",
            "series": [
              {
                "title": "Human Longevity",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/a8ef9c6b-cb5c-4551-b57c-baf261e80cc4.jpg?transform=w_1080"
                }
              },
              {
                "title": "Category 13",
                "id": "21",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/b7e4062a-f861-4273-8350-d548f6809e93.jpg?transform=w_1080"
                }
              },
              {
                "title": "Live Your Quest",
                "id": "10",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/e019134c-fdb0-497c-a613-6b9f1c7166a4.jpg?transform=w_1080"
                }
              },
              {
                "title": "The Barcelona Experiment ",
                "id": "11",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/e0f1bba7-2292-44e6-abbc-cf0137706181.jpg?transform=w_1080"
                }
              }
            ],
            "mediaCount": 25,
            "latestMedia": [
              {
                "type": "video",
                "title": "Human Longevity",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/8332c515-1552-4f5f-ac1a-cf11b99cb87f.jpg?transform=w_1080"
                }
              },
              {
                "type": "video",
                "title": "The Barcelona Experiment ",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/e0f1bba7-2292-44e6-abbc-cf0137706181.jpg?transform=w_1080"
                }
              },
              {
                "type": "video",
                "title": "Live Your Quest - The Documentary",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/c7f7f3ee-160c-476e-9993-50ec39203987.jpg?transform=w_1080"
                }
              }
            ],
            "iconAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/eb493421-c048-492b-a471-bed7604e95d6.jpg?transform=w_1080"
            },
            "coverAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/e819d374-a6d9-4308-bde1-1e145426e546.jpg?transform=w_1080"
            }
          },
          {
            "title": "Master's Circle",
            "series": [
              {
                "title": "Master's Circle",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/d4e30377-041a-47b4-b24a-19c598464b5c.jpg?transform=w_1080"
                }
              }
            ],
            "mediaCount": 103,
            "latestMedia": [
              {
                "type": "course",
                "title": "Live Big",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/f2a31086-d7d7-42a0-80eb-523dea2f3a0b.png?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Getting More Out of Yourself and your Business",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/11fc3705-60e6-4859-9c18-8c72a3b22ca7.png?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Presenting Brilliantly: Become a Confident, Influential, And Effective Speaker",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/05736f91-e160-4660-9c0d-4ff4d481f8b7.png?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Building A Transformational Business",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/2243fb19-c751-41ee-b2b7-20b63f2ceb2a.png?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Coaching Your Way To Success",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/eb5cef27-96cb-4e68-8ef5-8bf0d0436e83.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "The Matrix Of Transformation",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/37b38f58-084e-49ea-bfc1-671599e00c53.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Grow Your Business Without Spending Money On Ads",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/15842e9d-e3a1-4ab7-abb7-0ac288a2c03b.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Creating The Outline of Your Bestselling Book",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/3e120ea9-b5d9-4e2c-93bf-4c0e1e1eb1cd.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "How To Launch Your Podcast",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/42871b55-ad29-48d2-a67e-1c39bf0e4cf6.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "How To Coach Your Clients To Share Their Message Authentically",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/2ed69a6b-bde5-4c70-9f13-6b545cacad06.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "The 3 Must-Know Secrets to Persuasive Copy",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/d308dee2-614b-4089-9ef3-4bab1a43737a.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "How To Coach Your Clients On Overcoming Limiting Beliefs About Relationships",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/b3929564-c745-45f1-89ce-d5ae684259de.jpg?transform=w_1080"
                }
              }
            ],
            "iconAsset": null,
            "coverAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/275910e6-9a45-4989-b7c1-8961169833cf.jpg?transform=w_1080"
            }
          },
          {
            "title": "Lifebook Accountability System",
            "series": [
              {
                "title": "Getting Started with the Lifebook Accountability System",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/4d960fc3-836a-4536-8ba7-062911943477.jpg?transform=w_1080"
                }
              }
            ],
            "mediaCount": 6,
            "latestMedia": [
              {
                "type": "course",
                "title": "Welcome to the Lifebook Accountability System!",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/03acac58-af60-484a-8b8f-696b171eeb26.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "The Accountability Year",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/fa053bfb-fdc4-4ab1-a93e-0709d9171f54.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Your Life Vision, Refined",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/d78cbc7f-4d43-414a-b83a-62f8137cfbb5.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Your Goal Tracking Approach",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/09ca9c67-acfe-4d0d-ac31-1588053a0596.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Completing Your Accountability Profile",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/4eb672a9-540d-4143-82b3-ef01dc9d37ec.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "The Lifeline Exercise",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/7f55fbbd-bf6b-4810-b605-2177b9fc6db4.jpg?transform=w_1080"
                }
              }
            ],
            "iconAsset": {
              "thumbnailUrl": "https://edgecastcdn.net/80EC13/public/overmind2/asset/ae4b0861-b54c-4e56-b573-107466e0e384/channel-icon-lifebook_thumbnail.png"
            },
            "coverAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/46a6f2aa-e645-4473-92cb-0c6add8bd039.jpg?transform=w_1080"
            }
          },
          {
            "title": "Little Humans",
            "series":[],
            "mediaCount": 17,
            "latestMedia": [
              {
                "type": "course",
                "title": "Conscious Parenting",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/5bdbdd0e-3bd3-432b-b8cb-3d3556c58c94.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Raising Kids With Healthy Beliefs",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/cb8c79d9-af35-4727-9c4c-6e9eee5af1c3.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Attachment Parenting: Nurturing Our Children",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/9accb76c-fc05-4455-b20c-a39f947184a7.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Superparenting For Distracted Kids",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/2f48bea4-24c8-4561-a984-7fb5f581e104.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Navigating Loss & Grief",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/31998524-3925-41c1-b4b3-279d8c833558.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Raising Resilient Kids",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/f081b68f-23bb-4a24-8adb-6717d976486c.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Mother’s Health & Postpartum Care",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/a013413d-3831-47f9-baea-0b1bc9295217.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "The Cornerstones Of Emotional Intelligence",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/20fad636-efad-485a-8b26-93bcdacc76ea.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Secrets Of Successful Co-Parenting",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/47e0e610-1e3b-4716-ac95-c5ef51b6f175.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Breaking Unhealthy Food Habits",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/c2f13311-d65a-4baf-ade4-d71009138f1c.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Making Learning Fun",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/4292c6be-ee60-454c-800c-f6e33d9c966f.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "Parenting In The Modern Age",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/eacc514b-3765-42f0-90f3-f4a7c7a63d7d.jpg?transform=w_1080"
                }
              }
            ],
            "iconAsset": null,
            "coverAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/5d3da561-2e8b-4551-ad3f-11048adfc73c.jpg?transform=w_1080"
            }
          },
          {
            "title": "Unlimited Abundance",
            "slug": "unlimited_abundance",
            "series": [
              {
                "title": "Unlimited Abundance Program",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/34b459cd-5a5c-400e-9e02-ae1481a1a87b.jpg?transform=w_1080"
                }
              },
              {
                "title": "Bonuses for Unlimited Abundance",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/4bdbc2ce-d9cd-47cc-8891-4252a8bf0afc.jpg?transform=w_1080"
                }
              }
            ],
            "mediaCount": 59,
            "latestMedia": [
              {
                "type": "course",
                "title": "Introduction Video",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/d3225076-45b6-4ad6-b0a7-2316b26e6676.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "1. Clearing Resistance",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/a6be0a22-6538-466c-80d8-bfcb6ce94b81.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "2. Clearing Doubt and Fear",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/5c310335-073b-47db-aee8-2c93095c8f45.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "3. Clearing the Fear of Change",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/d3de2291-b684-4ea8-ab71-956efdd1a18e.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "4. Clearing Money Zapping Decisions",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/ded6292a-9b07-4dfa-a46d-5e68419fa391.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "5. Clearing Fear of Growth",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/929012ab-5be4-45d3-90f0-bfa216715d5c.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "6. Clearing Fear of Success",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/6581c64d-fafc-4c35-ac4c-189f3f321ce7.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "7. Clearing Fear of Rejection",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/589ece85-d0f5-4542-83ce-00179ec4ba6d.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "8. Clearing Fear of Numbers",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/2ee7362a-402b-4030-8351-fa7dcbb96d1f.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "9. Clearing Indecision",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/f44f9c56-1d46-4546-8d19-10b30d1c0899.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "10. Clearing Feeling Stuck",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/362d5288-ca0c-4707-bc71-edba545508fe.jpg?transform=w_1080"
                }
              },
              {
                "type": "course",
                "title": "11. Getting Clear on Your Values",
                "coverAsset": {
                  "url": "https://assets.mindvalley.com/api/v1/assets/f98da5b1-4389-4db0-99ef-dbfe7ad654b1.jpg?transform=w_1080"
                }
              }
            ],
            "iconAsset": null,
            "coverAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/aa833424-e1b7-463b-b1a1-f7faa222f8d0.jpg?transform=w_1080"
            }
          }
        ]
      }
    }
    """
    
    // New Episode Response Data
    static let episodesJSON = """
    {
      "data": {
        "media": [
          {
            "type": "course",
            "title": "Conscious Parenting",
            "coverAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/5bdbdd0e-3bd3-432b-b8cb-3d3556c58c94.jpg?transform=w_1080"
            },
            "channel": {
              "title": "Little Humans"
            }
          },
          {
            "type": "course",
            "title": "Raising Kids With Healthy Beliefs",
            "coverAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/cb8c79d9-af35-4727-9c4c-6e9eee5af1c3.jpg?transform=w_1080"
            },
            "channel": {
              "title": "Little Humans"
            }
          },
          {
            "type": "course",
            "title": "Attachment Parenting: Nurturing Our Children",
            "coverAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/9accb76c-fc05-4455-b20c-a39f947184a7.jpg?transform=w_1080"
            },
            "channel": {
              "title": "Little Humans"
            }
          },
          {
            "type": "course",
            "title": "Superparenting For Distracted Kids",
            "coverAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/2f48bea4-24c8-4561-a984-7fb5f581e104.jpg?transform=w_1080"
            },
            "channel": {
              "title": "Little Humans"
            }
          },
          {
            "type": "course",
            "title": "Navigating Loss & Grief",
            "coverAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/31998524-3925-41c1-b4b3-279d8c833558.jpg?transform=w_1080"
            },
            "channel": {
              "title": "Little Humans"
            }
          },
          {
            "type": "course",
            "title": "Recorded Live Calls: Intellectual Life",
            "coverAsset": {
              "url": "https://assets.mindvalley.com/api/v1/assets/273a5e20-8088-4e94-8f34-6b0241e93962.jpg?transform=w_1080"
            },
            "channel": {
              "title": "Lifebook Membership"
            }
          }
        ]
      }
    }
    """
    
    // category Response Data
    static let categoriesJSON = """
    {
      "data": {
        "categories": [
          {
            "name": "Career"
          },
          {
            "name": "Character"
          },
          {
            "name": "Emotional"
          },
          {
            "name": "Financial"
          },
          {
            "name": "Health & Fitness"
          },
          {
            "name": "Intellectual"
          },
          {
            "name": "Life Vision"
          },
          {
            "name": "Love Relationship"
          },
          {
            "name": "Parenting"
          },
          {
            "name": "Quality of Life"
          },
          {
            "name": "Social Life"
          },
          {
            "name": "Spiritual"
          }
        ]
      }
    }
    """
    
    static var mockChannelsData: Data? {
        return channelsJSON.data(using: .utf8)
    }
    
    static var mockEpisodesData: Data? {
        return episodesJSON.data(using: .utf8)
    }
    
    static var mockCategoriesData: Data? {
        return categoriesJSON.data(using: .utf8)
    }
}
