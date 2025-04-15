import 'dart:typed_data';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loggedIn = false;
  String? name;
  String? _gender;  // 是否有直播经验

  String? _video;   // 是否有视频剪辑经验
  String? _cycling; // 是否有自行车骑行经验
  String? _sing;    // 是否会唱歌
  String? _dance;   // 是否会跳舞

  //unit_name
  final _unitController   = TextEditingController();  // 学校名称
  final _nameController   = TextEditingController();  // 姓名
  final _otherControlle   = TextEditingController();  // 其他文艺爱好
  final _majorControlle   = TextEditingController();  // 专业
  final _phoneControlle   = TextEditingController();  // 手机
  final _numberControlle  = TextEditingController();  // 身份证
  final _heightControlle  = TextEditingController();  // 身高
  final _weightControlle  = TextEditingController();  // 体重
  final _ageControlle     = TextEditingController();  // 年龄
  final _numbersControlle = TextEditingController();  // 服装号码
// 新增图片相关状态
 // Uint8List? _selectedImage;
  String? _imageName;
  //bool _isUploading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('泉城骑行星主播报名表'),
      ),
      body: Center(
        child: loggedIn ? _buildSuccess() : _buildLoginForm(),
      ),
    );
  }
  Map< String, String > toJson(){
    final Map< String, String > para = Map<String, String>();
    para['unit_name'] = _unitController.text;
    para["name"] = _nameController.text;
    para["age"] = _ageControlle.text;
    para["hig"] = _heightControlle.text;
    para["phone"] = _phoneControlle.text;
    para["number_id"] = _numberControlle.text;
    para["major"] = _majorControlle.text;
    para["numbers"] = _numbersControlle.text;
    para["live"] = _gender ?? '';
    para["voide"] = _video ?? '';
    para["cycling"] = _cycling ?? '';
    para["sing"] = _sing ?? '';
    para["dance"] = _dance ?? '';
    para["other"] = _otherControlle.text;
    para["weight"] = _weightControlle.text;
    return para;
    // return jsonEncode( para );
  }

  //async await
  Future<Map<String, dynamic>> PostBuildHtml() async {
    final url = Uri.parse('http://api.liangjianfuneng.com/user/open/sign');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(toJson()),
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return responseData; // 返回解析后的数据
    // return response.body; // 返回 Future<String>
  }
/*
  Widget _buildSuccess() {
    Map<String, dynamic> show = PostBuildHtml();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.check, color: Colors.orangeAccent),
        Text(show['msg'])
      ],
    );
  }
 */
  Future<Map<String, dynamic>> postBuildHtml() async {
    try {
      final url = Uri.parse('http://api.liangjianfuneng.com/user/open/sign');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('请求失败，状态码: ${response.statusCode}');
      }

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData;
    } catch (e) {
      throw Exception('请求异常: $e');
    }
  }

  Widget _buildSuccess() {
    return FutureBuilder<Map<String, dynamic>>(
      future: postBuildHtml(),
      builder: (context, snapshot) {
        // 处理加载状态
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // 处理错误状态
        if (snapshot.hasError) {
          return Column(
            children: [
              const Icon(Icons.error, color: Colors.red),
              Text('错误: ${snapshot.error}'),
            ],
          );
        }

        // 处理空数据
        if (!snapshot.hasData) {
          return const Text('没有获取到数据');
        }

        // 数据展示
        final data = snapshot.data!;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check, color: Colors.orangeAccent),
            Text(data['data'] ?? '默认提示信息'),
          ],
        );
      },
    );
  }



  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: '姓   名'
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return '请输入姓名';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _unitController,
                decoration: InputDecoration(
                    labelText: '学   校'
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return '请输入学校名称';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _ageControlle,
                decoration: InputDecoration(
                    labelText: '年   龄'
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return '请输入年龄';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _heightControlle,
                decoration: InputDecoration(
                    labelText: '身   高(cm)'
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return '请输入身高';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _weightControlle,
                decoration: InputDecoration(
                    labelText: '体     重(kg)'
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return '请输入体重';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _phoneControlle,
                decoration: InputDecoration(
                    labelText: '手机号'
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return '请输入手机号';
                  }
                  final regex = RegExp(r'^1[3-9]\d{9}$');
                  if ( !regex.hasMatch(text) ){
                    return '请输入正确的手机号';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _numberControlle,
                decoration: InputDecoration(
                    labelText: '身份证'
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return '请输入身份证号';
                  }
                  final regex = RegExp(r'^[1-9]\d{5}(19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])\d{3}[\dXx]$');
                  if ( !regex.hasMatch(text) ){
                    return '请输入正确的身份证号';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _majorControlle,
                decoration: InputDecoration(
                    labelText: '专   业'
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return '请输入专业';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _numbersControlle,
                decoration: InputDecoration(
                    labelText: '服装号码'
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return '请输入服装号码';
                  }
                  return null;
                },
              ),
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("是否有直播经验", style: TextStyle(fontSize: 16)), //, color: Colors.black54)),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text("有"),
                              value: "有",
                              groupValue: _gender,
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                                state.didChange(value);
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text("无"),
                              value: "无",
                              groupValue: _gender,
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                                state.didChange(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      if (state.hasError)
                        Text(
                          state.errorText!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                    ],
                  );
                },
                validator: (value) {
                  return value == null ? '请选择有过直播经验' : null;
                },
              ),

              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("是否会视频剪辑", style: TextStyle(fontSize: 16)), //, color: Colors.black54)),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text("有"),
                              value: "有",
                              groupValue: _video,
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              onChanged: (value) {
                                setState(() {
                                  _video = value;
                                });
                                state.didChange(value);
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text("无"),
                              value: "无",
                              groupValue: _video,
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              onChanged: (value) {
                                setState(() {
                                  _video = value;
                                });
                                state.didChange(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      if (state.hasError)
                        Text(
                          state.errorText!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                    ],
                  );
                },
                validator: (value) {
                  return value == null ? '请选择是否有视频剪辑经验' : null;
                },
              ),

              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("自行车骑行经验", style: TextStyle(fontSize: 16)), //, color: Colors.black54)),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text("有"),
                              value: "有",
                              groupValue: _cycling,
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              onChanged: (value) {
                                setState(() {
                                  _cycling = value;
                                });
                                state.didChange(value);
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text("无"),
                              value: "无",
                              groupValue: _cycling,
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              onChanged: (value) {
                                setState(() {
                                  _cycling = value;
                                });
                                state.didChange(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      if (state.hasError)
                        Text(
                          state.errorText!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                    ],
                  );
                },
                validator: (value) {
                  return value == null ? '请选择是否有自行车骑行经验' : null;
                },
              ),

              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("是否会唱歌", style: TextStyle(fontSize: 16)), //, color: Colors.black54)),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text("会"),
                              value: "会",
                              groupValue: _sing,
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              onChanged: (value) {
                                setState(() {
                                  _sing = value;
                                });
                                state.didChange(value);
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text("不会"),
                              value: "不会",
                              groupValue: _sing,
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              onChanged: (value) {
                                setState(() {
                                  _sing = value;
                                });
                                state.didChange(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      if (state.hasError)
                        Text(
                          state.errorText!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                    ],
                  );
                },
                validator: (value) {
                  return value == null ? '请选择是否会唱歌' : null;
                },
              ),

              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("是否会跳舞", style: TextStyle(fontSize: 16)), //, color: Colors.black54)),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text("会"),
                              value: "会",
                              groupValue: _dance,
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              onChanged: (value) {
                                setState(() {
                                  _dance = value;
                                });
                                state.didChange(value);
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text("不会"),
                              value: "不会",
                              groupValue: _dance,
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              onChanged: (value) {
                                setState(() {
                                  _dance = value;
                                });
                                state.didChange(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      if (state.hasError)
                        Text(
                          state.errorText!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                    ],
                  );
                },
                validator: (value) {
                  return value == null ? '请选择是否会跳舞' : null;
                },
              ),
              TextFormField(
                controller: _otherControlle,
                decoration: InputDecoration(
                    labelText: '其他文艺爱好'
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('     提   交      '),
                onPressed: _validate,
              ),
              SizedBox(height: 300),
            ],
          ),
        ),
      ),
    );
  }
  void _validate() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        loggedIn = true;
        name = _nameController.text;
      });
    }
  }
}

