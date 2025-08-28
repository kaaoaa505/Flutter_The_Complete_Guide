<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Message;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class MessageController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): JsonResponse
    {
        $messages = Message::orderBy('created_at', 'asc')->get();
        return response()->json([
            'success' => true,
            'data' => $messages
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'sender' => 'required|string|max:255',
            'content' => 'required|string',
        ]);

        $message = Message::create([
            'sender' => $request->sender,
            'content' => $request->content,
        ]);

        return response()->json([
            'success' => true,
            'data' => $message,
            'message' => 'Message sent successfully'
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Message $message): JsonResponse
    {
        return response()->json([
            'success' => true,
            'data' => $message
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Message $message): JsonResponse
    {
        $request->validate([
            'sender' => 'sometimes|required|string|max:255',
            'content' => 'sometimes|required|string',
        ]);

        $message->update($request->only(['sender', 'content']));

        return response()->json([
            'success' => true,
            'data' => $message,
            'message' => 'Message updated successfully'
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Message $message): JsonResponse
    {
        $message->delete();

        return response()->json([
            'success' => true,
            'message' => 'Message deleted successfully'
        ]);
    }
}